local lsp = require('lsp-zero').preset({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = ''
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr}
    local bind = vim.keymap.set

    bind('n', '<leader>lf', '<cmd>LspZeroFormat<cr>', opts)
    -- more keybindings...
end)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
