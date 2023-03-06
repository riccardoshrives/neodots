return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        { 'williamboman/mason.nvim' }, -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' }, -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/cmp-buffer' }, -- Optional
        { 'hrsh7th/cmp-path' }, -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' }, -- Optional

        -- Snippets
        { 'L3MON4D3/LuaSnip' }, -- Required
        { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
        local lsp = require('lsp-zero').preset({
            name = "recommended",
            suggest_lsp_servers = true,
            setup_servers_on_start = true,
            set_lsp_keymaps = true,
            configure_diagnostics = true,
            cmp_capabilities = true,
            manage_nvim_cmp = true,
            manage_luasnip = true,
            call_servers = 'local',
            sign_icons = {
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = ''
            }
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr }
            local bind = vim.keymap.set

            bind('n', '<leader>lf', '<cmd>LspZeroFormat<cr>', opts)
            -- more keybindings...
        end)

        -- (Optional) Configure lua language server for neovim
        lsp.nvim_workspace()

        lsp.setup()
    end
}
