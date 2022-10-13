local colorscheme = "nvcode"

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

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
