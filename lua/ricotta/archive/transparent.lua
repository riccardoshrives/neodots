return {
    "riccardoshrives/nvim-transparent",
    opts = {
        enable = false,
        extra_groups = { -- table/string: additional groups that should be cleared
            -- In particular, when you set it to 'all', that means all available groups
            'TelescopeNormal',
            'TelescopePromptNormal'
        },
        exclude = { -- table; groups you don't want to be clear
        },
    }
}
