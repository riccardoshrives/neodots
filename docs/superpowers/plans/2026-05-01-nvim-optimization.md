# Neovim Config Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix checkhealth correctness issues and reduce startup time from ~1029ms to under 400ms via targeted lazy-loading improvements.

**Architecture:** Two sequential passes — correctness fixes first (safe, non-breaking), then lazy-loading changes (one plugin at a time). Each task ends with a commit and a verification step so regressions are caught immediately.

**Tech Stack:** Neovim 0.13 (debug build), lazy.nvim, lua, pnpm, uv

---

## File Map

| File | What changes |
|------|-------------|
| `init.lua` | Add provider disable flags before `require "config.lazy"` |
| `lua/plugins/lsp.lua` | Remove `jedi_language_server`; remove `neodev.nvim` dep; add `event = "LspAttach"` + nvim-tree fix to fidget; add `event = "BufReadPre"` to null-ls |
| `lua/plugins/lazydev.lua` | Create new — replaces neodev.nvim |
| `lua/plugins/snacks.lua` | Remove `lazy = false` and `priority = 1000` |
| `lua/plugins/icon-picker.lua` | Add `cmd` trigger; remove `config` keymap calls |
| `lua/plugins/harpoon.lua` | Add `keys` trigger to drive lazy-loading |
| `lua/plugins/indent_line.lua` | Add `event = "BufRead"` |
| `lua/plugins/dadbod.lua` | Split into structured specs; add `ft` trigger to completion plugin |

---

## Task 1: Install system packages

No config changes. These fix the `neovim` npm package and outdated `pynvim` provider warnings.

**Files:** none

- [ ] **Step 1: Install neovim npm package via pnpm**

```bash
pnpm install -g neovim
```

Expected output: something like `added 1 package in Xs`

- [ ] **Step 2: Upgrade pynvim via uv**

```bash
uv pip install --upgrade pynvim
```

Expected output: `Successfully installed pynvim-0.6.0` (or later)

> **Note:** If your uv Python is in a venv rather than globally on `$PATH`, nvim won't find it. Check with `which python3` — if it's not the uv-managed one, you'll need to set `vim.g.python3_host_prog` in `plugin/options.lua` pointing to the venv's Python binary. Skip this note if `which python3` already shows your uv Python.

- [ ] **Step 3: Verify providers in checkhealth**

Open nvim and run:
```
:checkhealth vim.provider
```

Expected: Node.js and Python 3 provider sections now show OK (no "neovim npm package missing" or "pynvim outdated" warnings). Perl warning will remain — that's intentional (handled in Task 2).

---

## Task 2: Disable unused providers

Suppresses the perl, ruby, and node provider warnings at the source. Must be in `init.lua` — `plugin/` files are sourced after lazy.nvim starts, too late to suppress provider loading.

**Files:**
- Modify: `init.lua`

- [ ] **Step 1: Add provider disable flags to init.lua**

Open `init.lua`. It currently reads:

```lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
require "config.lazy"
```

Change to:

```lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

require "config.lazy"
```

- [ ] **Step 2: Verify**

Open nvim and run:
```
:checkhealth vim.provider
```

Expected: Perl and Ruby provider sections now show as disabled (no warnings). Node provider likewise disabled.

- [ ] **Step 3: Commit**

```bash
git add init.lua
git commit -m "fix: disable unused perl, ruby, node providers"
```

---

## Task 3: Remove jedi_language_server, keep pyright

`lua/plugins/lsp.lua` currently configures both `pyright` and `jedi_language_server` for Python. They compete at runtime. Remove jedi entirely.

**Files:**
- Modify: `lua/plugins/lsp.lua`

- [ ] **Step 1: Remove jedi from the servers table**

In `lua/plugins/lsp.lua`, find the `local servers = { ... }` table. Remove the `jedi_language_server` entry:

```lua
-- Remove this line:
jedi_language_server = {},
```

Keep `pyright = {}` in the table.

- [ ] **Step 2: Verify**

Open nvim, then open any `.py` file:
```
:LspInfo
```

Expected: Only `pyright` appears as the active client. No `jedi_language_server`.

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/lsp.lua
git commit -m "fix: remove jedi_language_server, keep pyright for Python"
```

---

## Task 4: Replace neodev.nvim with lazydev.nvim

`neodev.nvim` is deprecated. `lazydev.nvim` is its maintained replacement. It improves Lua LSP completions and type annotations for your nvim config files.

**Files:**
- Modify: `lua/plugins/lsp.lua` (remove neodev dependency)
- Create: `lua/plugins/lazydev.lua`

- [ ] **Step 1: Remove neodev from lsp.lua dependencies**

In `lua/plugins/lsp.lua`, find the `dependencies = { ... }` table at the top of the lspconfig spec. Remove this line:

```lua
-- Remove this line:
{ "folke/neodev.nvim", opts = {} },
```

- [ ] **Step 2: Create lua/plugins/lazydev.lua**

```lua
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
```

- [ ] **Step 3: Verify**

Open `lua/plugins/lsp.lua` in nvim. Run:
```
:LspInfo
```

Expected: `lua_ls` is active. Then try triggering completion on `vim.` — you should still get nvim API completions. Run `:checkhealth` and confirm no neodev-related errors.

- [ ] **Step 4: Commit**

```bash
git add lua/plugins/lsp.lua lua/plugins/lazydev.lua
git commit -m "fix: replace deprecated neodev.nvim with lazydev.nvim"
```

---

## Task 5: Defer fidget.nvim to LspAttach + fix nvim-tree warning

Two changes merged into one: defer fidget's load event (saves ~65ms) and disable its implicit nvim-tree integration (fixes checkhealth warning).

**Files:**
- Modify: `lua/plugins/lsp.lua`

- [ ] **Step 1: Measure startup baseline before making any changes**

```bash
nvim --startuptime /tmp/startup-before.log --headless -c 'qall' && tail -1 /tmp/startup-before.log
```

Note the total time — this is the baseline to compare against after all lazy-loading tasks are done.

- [ ] **Step 2: Update the fidget dependency spec in lsp.lua**

In `lua/plugins/lsp.lua`, find the fidget entry inside `dependencies = { ... }`:

```lua
-- Current:
{ "j-hui/fidget.nvim", opts = {} },
```

Replace with:

```lua
{ "j-hui/fidget.nvim", event = "LspAttach", opts = { integration = { nvim_tree = { enabled = false } } } },
```

- [ ] **Step 4: Verify fidget deferred**

Open nvim with a file that has no LSP:
```bash
nvim /tmp/test.txt
```

Run `:Lazy` — fidget should show as "not loaded". Then open a Lua file:
```bash
nvim lua/plugins/lsp.lua
```

After a moment (LSP attaches), run `:Lazy` — fidget should now show as "loaded".

- [ ] **Step 5: Verify no nvim-tree warning**

```
:checkhealth fidget
```

Expected: No warning about nvim-tree implicit integration.

- [ ] **Step 6: Commit**

```bash
git add lua/plugins/lsp.lua
git commit -m "perf: defer fidget to LspAttach, disable nvim-tree integration"
```

---

## Task 6: Make snacks.nvim lazy

snacks loads with `priority = 1000, lazy = false` but has every feature commented out. Remove the eager-load flags so it doesn't run at startup for nothing.

**Files:**
- Modify: `lua/plugins/snacks.lua`

- [ ] **Step 1: Update snacks.lua**

The current file:

```lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- bigfile = { enabled = true },
    ...
  },
}
```

Change to:

```lua
return {
  "folke/snacks.nvim",
  lazy = true,
  ---@type snacks.Config
  opts = {
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- explorer = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    -- picker = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
}
```

- [ ] **Step 2: Verify nvim still starts cleanly**

```bash
nvim --headless -c 'qall'
```

No errors. Run `:Lazy` in a normal session — snacks should show as "not loaded".

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/snacks.lua
git commit -m "perf: make snacks.nvim lazy (all features still disabled)"
```

---

## Task 7: Defer vim-dadbod-completion to SQL filetypes

`vim-dadbod-completion` currently loads at every startup via its `after/plugin` file (63ms). Adding an explicit `ft` trigger in the lazy spec tells lazy.nvim to defer it.

**Files:**
- Modify: `lua/plugins/dadbod.lua`

- [ ] **Step 1: Restructure dadbod.lua with explicit specs**

Current file:

```lua
return {
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-completion',
  'kristijanhusak/vim-dadbod-ui',
}
```

Change to:

```lua
return {
  { 'tpope/vim-dadbod', lazy = true },
  {
    'kristijanhusak/vim-dadbod-completion',
    ft = { 'sql', 'mysql', 'plsql' },
    dependencies = { 'tpope/vim-dadbod' },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    dependencies = { 'tpope/vim-dadbod' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
```

> **Note:** `vim-dadbod` itself is set `lazy = true` because it has no UI — it's a library loaded by the other two. The UI is triggered by commands; completion by filetype.

- [ ] **Step 2: Measure startup saving**

```bash
nvim --startuptime /tmp/startup-dadbod.log --headless -c 'qall' && tail -1 /tmp/startup-dadbod.log
```

Expected: ~60ms reduction vs the baseline from Task 5 Step 2.

- [ ] **Step 3: Verify dadbod still works**

Open nvim and run `:DBUI` — the UI should open (triggering dadbod-ui load). Then open a `.sql` file — completion should be available via `<C-x><C-o>` or your cmp trigger.

- [ ] **Step 4: Commit**

```bash
git add lua/plugins/dadbod.lua
git commit -m "perf: defer vim-dadbod-completion to SQL filetypes (~60ms)"
```

---

## Task 8: Defer icon-picker to commands

icon-picker loads at startup (38ms) despite only being used interactively. Gate it on its commands.

**Files:**
- Modify: `lua/plugins/icon-picker.lua`

- [ ] **Step 1: Add cmd trigger and restructure config**

Current file:

```lua
return {
  'ziontee113/icon-picker.nvim',
  enabled = true,
  config = function()
    require('icon-picker').setup { disable_legacy_commands = true }

    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', '<Leader><Leader>i', '<cmd>IconPickerNormal<cr>', opts)
    vim.keymap.set('n', '<Leader><Leader>y', '<cmd>IconPickerYank<cr>', opts)
  end,
}
```

Change to:

```lua
return {
  'ziontee113/icon-picker.nvim',
  enabled = true,
  cmd = { 'IconPickerNormal', 'IconPickerYank', 'IconPickerInsert' },
  keys = {
    { '<Leader><Leader>i', '<cmd>IconPickerNormal<cr>', desc = 'Icon Picker' },
    { '<Leader><Leader>y', '<cmd>IconPickerYank<cr>', desc = 'Icon Picker (yank)' },
  },
  config = function()
    require('icon-picker').setup { disable_legacy_commands = true }
  end,
}
```

> The keymaps move to the `keys` table so lazy.nvim creates stub mappings at startup — pressing them loads the plugin and re-executes the key. The `config` function no longer needs `vim.keymap.set` since lazy handles it.

- [ ] **Step 2: Verify**

Open nvim, run `:Lazy` — icon-picker should be "not loaded". Press `<Leader><Leader>i` — the picker should open (and icon-picker now appears as "loaded" in `:Lazy`).

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/icon-picker.lua
git commit -m "perf: defer icon-picker to commands/keys (~38ms)"
```

---

## Task 9: Defer harpoon to keymaps

harpoon loads at startup (30ms). Add a `keys` trigger to lazy.nvim so it loads on first keypress.

**Files:**
- Modify: `lua/plugins/harpoon.lua`

- [ ] **Step 1: Add keys table as lazy-load trigger**

Current file:

```lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    vim.keymap.set("n", "<m-h><m-m>", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<m-h><m-l>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set("n", string.format("<space>%d", idx), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
```

Change to:

```lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {
    { "<m-h><m-m>", desc = "Harpoon add file" },
    { "<m-h><m-l>", desc = "Harpoon menu" },
    { "<space>1", desc = "Harpoon file 1" },
    { "<space>2", desc = "Harpoon file 2" },
    { "<space>3", desc = "Harpoon file 3" },
    { "<space>4", desc = "Harpoon file 4" },
    { "<space>5", desc = "Harpoon file 5" },
  },
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    vim.keymap.set("n", "<m-h><m-m>", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<m-h><m-l>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set("n", string.format("<space>%d", idx), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
```

> The `keys` table gives lazy.nvim stub mappings to intercept at startup. When any key fires, lazy loads harpoon and re-executes the press. The `config` function then overwrites the stubs with the real implementations.

- [ ] **Step 2: Verify**

Open nvim, run `:Lazy` — harpoon should be "not loaded". Open a file and press `<m-h><m-m>` — harpoon should add the file (and appear as "loaded" in `:Lazy`). Press `<space>1` through `<space>5` to confirm those work too.

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/harpoon.lua
git commit -m "perf: defer harpoon to first keypress (~30ms)"
```

---

## Task 10: Defer indent-blankline to BufRead

ibl only renders in open buffers. There's no reason to load it before the first buffer is read.

**Files:**
- Modify: `lua/plugins/indent_line.lua`

- [ ] **Step 1: Add event trigger**

Current file:

```lua
return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
```

Change to:

```lua
return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    main = 'ibl',
    opts = {},
  },
}
```

- [ ] **Step 2: Verify**

Open nvim to a blank screen (no file). Run `:Lazy` — ibl should be "not loaded". Open any file — indent guides should appear and ibl should now show as "loaded".

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/indent_line.lua
git commit -m "perf: defer indent-blankline to BufRead (~24ms)"
```

---

## Task 11: Defer null-ls to BufReadPre

null-ls registers formatters/linters per buffer. It has no effect at startup and can safely load on first buffer read.

**Files:**
- Modify: `lua/plugins/lsp.lua`

- [ ] **Step 1: Add event to the null-ls dependency in lsp.lua**

In `lua/plugins/lsp.lua`, find the `dependencies = { ... }` block for `nvim-lspconfig`. Find the none-ls entry:

```lua
-- Current:
{ "nvimtools/none-ls.nvim" },
```

Change to:

```lua
{ "nvimtools/none-ls.nvim", event = "BufReadPre" },
```

- [ ] **Step 2: Verify**

Open nvim to the dashboard or empty screen. Run `:Lazy` — none-ls should be "not loaded". Open a Python file and save it — black formatting should run. none-ls should now show as "loaded" in `:Lazy`.

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/lsp.lua
git commit -m "perf: defer null-ls to BufReadPre (~24ms)"
```

---

## Task 12: Final verification

Measure the total improvement and confirm everything works end-to-end.

**Files:** none

- [ ] **Step 1: Measure final startup time**

```bash
nvim --startuptime /tmp/startup-final.log --headless -c 'qall' && tail -1 /tmp/startup-final.log
```

Expected: total time under 400ms. Compare to baseline (~1029ms from Task 5 Step 2).

- [ ] **Step 2: Run checkhealth and count warnings**

```bash
nvim --headless -c 'checkhealth' -c 'w! /tmp/checkhealth-final.txt' -c 'qa' 2>/dev/null
grep -E "(⚠️|❌)" /tmp/checkhealth-final.txt | grep -v "^==" | wc -l
```

Expected: fewer than 10 warnings, 0 errors (the provider exception errors from headless runs should be gone since providers are now disabled).

- [ ] **Step 3: Manual smoke test**

Run through these in order:

```
# LSP — Python
nvim /tmp/test.py   # type: import os\nos.  → completions should appear

# LSP — TypeScript  
nvim /tmp/test.ts   # type: const x: str → type error should show

# LSP — Lua
nvim lua/plugins/lsp.lua   # type: vim. → nvim API completions should appear

# Formatting — Python (black)
nvim /tmp/test.py   # write unformatted code, :w → black should format on save

# Telescope
:Telescope find_files   → fuzzy finder opens

# Harpoon
<m-h><m-m>   → adds current file
<m-h><m-l>   → opens harpoon menu

# Dadbod UI
:DBUI   → dadbod UI opens

# Icon picker
<Leader><Leader>i   → icon picker opens

# Toggleterm
:ToggleTerm   → terminal opens
```

- [ ] **Step 4: Final commit if any minor fixes were needed**

```bash
git add -p   # stage any fixups
git commit -m "fix: post-optimization smoke test fixups"
```
