return {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
        { 'nvim-telescope/telescope.nvim' },
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
    },
    keys = { "<leader>?", ":Cheatsheet<CR>", desc = '[?]Cheatsheet', silent = true, noremap = true },
    config = true
}
