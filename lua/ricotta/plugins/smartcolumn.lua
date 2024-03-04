return {
    "m4xshen/smartcolumn.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        disabled_filetypes = {
            "alpha", "starter"
        }
    }
}
