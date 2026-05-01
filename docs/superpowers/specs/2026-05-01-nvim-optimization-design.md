# Neovim Config Optimization — Design Spec

**Date:** 2026-05-01
**Branch:** kickstart
**Scope:** Correctness fixes + lazy-loading pass (Approach B)

---

## Context

`checkhealth` and startup profiling revealed two categories of issues:

- **Correctness:** deprecated plugins, conflicting LSP servers, spurious provider warnings, implicit plugin integrations
- **Speed:** startup at ~1029ms due to several plugins loading eagerly at startup when they should be deferred

The nvim binary is a self-compiled debug build (`Build type: Debug`). Switching to a release build is out of scope — the user is intentionally tracking a dev/nightly build.

---

## Goals

- Startup time below 400ms (measured with `nvim --startuptime`)
- Zero errors in `checkhealth`; significantly reduced warning count
- All existing features continue to work: LSP (Python/TS/Lua/SQL), formatting, telescope, harpoon, dadbod, icon-picker, toggleterm

---

## Out of Scope

- `null-ls` → `conform`/`nvim-lint` migration (future pass)
- Enabling `snacks.nvim` features (user is planning this separately)
- Narrowing `emmet_language_server` filetypes
- Switching to a Homebrew/release nvim build

---

## Section 1: Correctness Fixes

### 1.1 Remove `jedi_language_server`

**File:** `lua/plugins/lsp.lua`

Both `pyright` and `jedi_language_server` are configured for Python. They compete at runtime. Remove `jedi_language_server` from the `servers` table and from `ensure_installed`.

Keep `pyright` only.

### 1.2 Replace `neodev.nvim` → `lazydev.nvim`

**File:** `lua/plugins/lsp.lua`

`neodev.nvim` is deprecated. `lazydev.nvim` is its maintained replacement and is a drop-in for the Lua LSP setup use case.

- Remove `{ "folke/neodev.nvim", opts = {} }` from the `lspconfig` dependencies
- Add a new plugin spec file `lua/plugins/lazydev.lua` with `{ "folke/lazydev.nvim", ft = "lua", opts = {} }`

No changes needed to the `lua_ls` server config.

### 1.3 Disable unused providers

**File:** `init.lua`

Add these before `require("config.lazy")` to suppress the provider warnings in `checkhealth`. Must be in `init.lua` — `plugin/` files are sourced after lazy starts, too late to suppress provider loading. These are optional providers that are not used:

```lua
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
```

### 1.4 Fix `fidget` nvim-tree implicit integration

**File:** `lua/plugins/lsp.lua` (fidget dependency opts)

The fidget integration with nvim-tree is implicitly enabled and will be removed in a future fidget release. Explicitly disable it:

```lua
{ "j-hui/fidget.nvim", opts = { integration = { nvim_tree = { enabled = false } } } }
```

### 1.5 System package installs

These are one-off shell commands, not config changes:

```sh
# Node.js provider (use pnpm)
pnpm install -g neovim

# Python provider (use uv)
uv pip install --upgrade pynvim
```

**Note on uv:** nvim resolves the Python interpreter from `$PATH` or `g:python3_host_prog`. If your uv Python lives in a venv rather than globally, set this in `plugin/options.lua`:

```lua
vim.g.python3_host_prog = "/path/to/your/uv/venv/bin/python"
```

---

## Section 2: Lazy-Loading Pass

All changes use lazy.nvim's built-in `event`, `cmd`, or `keys` triggers. Each plugin gets its own targeted fix.

### 2.1 `fidget.nvim` — defer to `LspAttach`

**File:** `lua/plugins/lsp.lua`

fidget only makes sense when an LSP client is active. Change its lazy.nvim trigger and merge with the nvim-tree fix from 1.4:

```lua
{ "j-hui/fidget.nvim", event = "LspAttach", opts = { integration = { nvim_tree = { enabled = false } } } }
```

**Expected saving:** ~65ms

### 2.2 `icon-picker.nvim` — load on command

**File:** `lua/plugins/icon-picker.lua`

icon-picker has no reason to load at startup. Gate it on its commands:

```lua
cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" }
```

**Expected saving:** ~35ms

### 2.3 `harpoon` — load on keymaps

**File:** `lua/plugins/harpoon.lua`

Harpoon should load only when a harpoon keymap is first pressed. Use `keys = { ... }` in the lazy spec with the keybindings already defined for it.

**Expected saving:** ~28ms

### 2.4 `indent-blankline` — defer to `BufRead`

**File:** `lua/plugins/indent_line.lua`

ibl only applies to open buffers. Deferring to `BufRead` is safe:

```lua
event = "BufRead"
```

**Expected saving:** ~24ms

### 2.5 `null-ls` — defer to `BufReadPre`

**File:** `lua/plugins/lsp.lua` (null-ls is a dependency of lspconfig in current config)

null-ls registers formatters/diagnostics per buffer. Deferring to `BufReadPre` is safe:

```lua
{ "nvimtools/none-ls.nvim", event = "BufReadPre" }
```

**Expected saving:** ~24ms

### 2.6 `vim-dadbod-completion` — gate on dadbod load

**File:** `lua/plugins/dadbod.lua`

`vim-dadbod-completion` loads via its `after/plugin` file (outside lazy.nvim's control), costing 63ms at every startup. Fix by adding an explicit lazy.nvim spec for it:

```lua
{ "kristijanhusak/vim-dadbod-completion", dependencies = { "tpope/vim-dadbod" }, ft = { "sql", "mysql", "plsql" } }
```

The `ft` trigger overrides the `after/plugin` autoload behavior when managed by lazy.nvim.

**Expected saving:** ~60ms

### 2.7 `snacks.nvim` — remove eager load

**File:** `lua/plugins/snacks.lua`

snacks is loaded with `priority = 1000, lazy = false` but has every feature commented out — it contributes startup overhead for no benefit. Change to:

```lua
lazy = true
```

Remove `priority = 1000` (only meaningful for eager-loaded plugins). When features are eventually enabled, re-evaluate whether eager loading is needed for specific ones (e.g. `dashboard`).

**Expected saving:** ~5ms (plus avoids snacks running its setup at every startup)

---

## Expected Outcome

| Metric | Before | After |
|--------|--------|-------|
| Startup time | ~1029ms | ~250–400ms |
| `checkhealth` errors | 5 (provider exceptions from headless run) | 0 |
| `checkhealth` warnings | ~30 | < 10 |
| Python LSP conflict | yes (pyright + jedi) | no (pyright only) |
| Deprecated plugins | neodev.nvim | none |

---

## Testing Plan

1. After each correctness fix: run `nvim --headless -c 'checkhealth' -c 'qa'` and verify warning count drops
2. After each lazy-loading change: open a file of the relevant type and verify the plugin activates correctly
3. Final startup measurement: `nvim --startuptime /tmp/startup.log --headless -c 'qall' && tail -1 /tmp/startup.log`
4. Manual smoke test: LSP (open a `.py`, `.ts`, `.lua` file), formatting (save a file), telescope, harpoon, dadbod, icon-picker, toggleterm
