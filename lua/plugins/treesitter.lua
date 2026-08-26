-- Highlight, edit, and navigate code
-- Uses the nvim-treesitter `main` branch (the `master` branch is frozen and
-- only supports Neovim <= 0.11). See `:h nvim-treesitter`.

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false, -- main branch does not support lazy-loading
  config = function()
    local ts = require 'nvim-treesitter'

    -- Parsers installed up front (async no-op if already installed)
    ts.install {
      'bash',
      'c',
      'html',
      'http',
      'javascript',
      'jsdoc',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'typescript',
      'vim',
      'vimdoc',
    }

    -- Languages that keep vim's regex highlighting alongside treesitter
    -- (some indent/plugin behaviour depends on it)
    local extra_regex_highlighting = { ruby = true, markdown = true }
    -- Languages where treesitter indentation is disabled
    local no_ts_indent = { ruby = true }

    local function enable_features(buf, lang)
      if not pcall(vim.treesitter.start, buf, lang) then
        return
      end
      if extra_regex_highlighting[lang] then
        vim.bo[buf].syntax = 'ON'
      end
      if not no_ts_indent[lang] then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('user.treesitter', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end
        if vim.tbl_contains(ts.get_installed(), lang) then
          enable_features(args.buf, lang)
        elseif vim.tbl_contains(ts.get_available(), lang) then
          -- Auto-install missing parsers, then enable features
          ts.install(lang):await(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
              enable_features(args.buf, lang)
            end
          end)
        end
      end,
    })
  end,
}
