return {
    'VonHeikemen/lsp-zero.nvim',
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },         -- Required
        { 'hrsh7th/cmp-nvim-lsp' },     -- Required
        { 'hrsh7th/cmp-buffer' },       -- Optional
        { 'hrsh7th/cmp-path' },         -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' },     -- Optional
        { 'onsails/lspkind.nvim' },     -- Optional

        -- Snippets
        { 'L3MON4D3/LuaSnip' },             -- Required
        { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
        local lsp = require('lsp-zero')

        lsp.preset("recommended")

        lsp.ensure_installed({
            "tsserver",
            "lua_ls"
        })

        -- Fix Undefined global 'vim'
        lsp.configure('lua-language-server', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-Space>'] = cmp.mapping.complete(),
        })

        local lspkind = require('lspkind')

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings,
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol',       -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                })
            }
        })

        lsp.on_attach(function(client, bufnr)
            local function opts(desc)
                return {
                    buffer = bufnr,
                    desc = desc,
                }
            end

            vim.keymap.set('n', '<leader>lf', '<cmd>LspZeroFormat<cr>', opts("[L]SP [F]ormat"))
            -- more keybindings...
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts("[g]o to [d]efinition"))
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts("LSP hover"))
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
                opts("[v]iew [w]orkspace [s]ymbols"))
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts("[v]iew [d]iagnostics"))
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts("[v]iew [c]ode [a]ctions"))
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts("[v]iew [r]eferences"))
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts("[r]e[n]ame references"))
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts("Signature [h]elp"))
        end)

        -- (Optional) Configure lua language server for neovim
        lsp.nvim_workspace()

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true
        })
    end
}
