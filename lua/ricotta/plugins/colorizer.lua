return {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    enabled = false,
    opts = {
        user_default_options = {
            names = false,
            css = true,                                     -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
            always_update = true,
        }
    }
}
