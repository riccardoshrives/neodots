return {
    "goolord/alpha-nvim",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = "  𝕟 𝕖 𝕠 𝕧 𝕚 𝕞  "

        dashboard.section.buttons.val = {
            dashboard.button("p", " " .. " Open project", ":Telescope projects <CR>"),
            dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
            dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
            dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
            dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
            -- dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
            dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
            dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        }

        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end

        dashboard.section.footer.opts.hl = "Normal"
        dashboard.section.header.opts.hl = "AlphaShortcut"
        dashboard.section.buttons.opts.hl = "AlphaButtons"

        -- require("alpha.term")
        -- local width = 46
        -- local height = 25 -- two pixels per vertical space
        -- dashboard.section.terminal.command = "cat | " .. os.getenv("HOME") .. "/.config/nvim/art/thisisfine.sh"
        -- dashboard.section.terminal.width = width
        -- dashboard.section.terminal.height = height
        -- dashboard.section.terminal.opts.redraw = true

        dashboard.config.layout = {
            { type = "padding", val = 10 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 5 },
            dashboard.section.footer,
        }

        local handle = io.popen("fortune -s")
        local fortune = handle:read("*a")
        handle:close()
        dashboard.section.footer.val = fortune

        dashboard.config.opts.noautocmd = true

        vim.cmd([[autocmd User AlphaReady echo 'ready']])

        alpha.setup(dashboard.config)

        vim.keymap.set("n", "<leader><CR>", ":Alpha <CR>", { silent = true, noremap = true, desc = "Toggle Alpha" })
    end,
}
