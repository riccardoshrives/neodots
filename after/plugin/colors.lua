local colorscheme = "tokyonight"

-- Material variables have to be set before applying the colorscheme
if colorscheme == "material" then
  vim.g.material_style = "lighter"
  local material = require "material"
  material.setup {
    -- disable = {
    --   background = true,
    -- },
  }
end

function ColorMe(color)
    color = color or colorscheme
    vim.cmd.colorscheme(color)
    -- keep things transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local status_ok, _ = pcall(ColorMe)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
