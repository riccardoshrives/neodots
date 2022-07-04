local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
    return
end

transparent.setup({
    enable = true,
    extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups
        "TabLine",
        "TabLineFill",
        "FoldColumn",

        -- bufferline
        "BufferLineTabClose",
        "BufferlineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineIndicatorSelected",

        -- telescope
        "TelescopeBorder",

        -- nvimtree
        "NvimTreeNormal",
        "NvimTreeVertSplit",

    },
    exclude = { -- table; groups you don't want to be clear

    }
})

-- Make TabLine transparent pls
vim.cmd('hi TabLineFill cterm=none gui=none guifg=none') 
