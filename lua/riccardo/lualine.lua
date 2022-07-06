local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local buffers = {
  "buffers",
  show_filename_only = true, -- Shows shortened relative path when set to false
  show_modified_status = true, -- Shows indicator when the buffer is modified

  max_length = vim.o.columns * 2 / 3,

  filetype_names = {
    TelescopePrompt = "Telescope",
    dashboard = "Dashboard",
    packer = "Packer",
    alpha = "Alpha",
  }, -- Shows a specific buffer name for that filetype

  symbols = {
    modified = " ●", -- Text to show when the buffer is modified
    alternate_file = "# ", -- Text to show to identify the alternate file
    directory = "", -- Text to show when the buffer is a directory
  },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local filename = {
  "filename",
  symbols = {
    modified = " ●",
    readonly = " ",
    unnamed = "– New File –",
  },
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local tabs = {
  "tabs",
  max_length = vim.o.columns / 3, -- Maximum width of tabs component.
  -- Note:
  -- It can also be a function that returns
  -- the value of `max_length` dynamically.
  mode = 2, -- 0: Shows tab_nr
  -- 1: Shows tab_name
  -- 2: Shows tab_nr + tab_name

  tabs_color = {
    -- Same values as the general color option can be used here.
    active = "TabLineSel", -- Color for active tab.
    inactive = "TabLineFill", -- Color for inactive tab.
  },
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", diagnostics },
    lualine_c = { "%=", filename },
    lualine_x = { diff, spaces, "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
  tabline = {},
}
