return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    -- or                            , branch = '0.1.x',
    dependencies = { 
        { "nvim-lua/plenary.nvim" }, 
        {
        "nvim-telescope/telescope-fzf-native.nvim", -- Required by some grep functions in telescope
        build = "make"
    } }
}
