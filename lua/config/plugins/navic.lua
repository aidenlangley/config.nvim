local M = {
  "SmiteshP/nvim-navic",
}

local function setup_colours()
  local colours = require("config.colours").THEME

  local function opts(colour)
    return {
      default = true,
      bg = colours.bg,
      fg = colour or colours.fg,
    }
  end

  local ni = "NavicIcons"
  vim.api.nvim_set_hl(0, ni .. "File", opts(colours.red))
  vim.api.nvim_set_hl(0, ni .. "Module", opts(colours.orange))
  vim.api.nvim_set_hl(0, ni .. "Namespace", opts(colours.orange))
  vim.api.nvim_set_hl(0, ni .. "Package", opts(colours.orange))
  vim.api.nvim_set_hl(0, ni .. "Class", opts(colours.yellow))
  vim.api.nvim_set_hl(0, ni .. "Method", opts(colours.blue))
  vim.api.nvim_set_hl(0, ni .. "Property", opts(colours.green))
  vim.api.nvim_set_hl(0, ni .. "Field", opts(colours.green))
  vim.api.nvim_set_hl(0, ni .. "Constructor", opts(colours.cyan))
  vim.api.nvim_set_hl(0, ni .. "Enum", opts(colours.yellow))
  vim.api.nvim_set_hl(0, ni .. "Interface", opts(colours.yellow))
  vim.api.nvim_set_hl(0, ni .. "Function", opts(colours.blue))
  vim.api.nvim_set_hl(0, ni .. "Variable", opts(colours.green))
  vim.api.nvim_set_hl(0, ni .. "Constant", opts(colours.yellow))
  vim.api.nvim_set_hl(0, ni .. "String", opts(colours.cyan))
  vim.api.nvim_set_hl(0, ni .. "Number", opts(colours.skyblue))
  vim.api.nvim_set_hl(0, ni .. "Boolean", opts(colours.magenta))
  vim.api.nvim_set_hl(0, ni .. "Array", opts(colours.green))
  vim.api.nvim_set_hl(0, ni .. "Object", opts(colours.yellow))
  vim.api.nvim_set_hl(0, ni .. "Key", opts(colours.violet))
  vim.api.nvim_set_hl(0, ni .. "Null", opts())
  vim.api.nvim_set_hl(0, ni .. "EnumMember", opts(colours.green))
  vim.api.nvim_set_hl(0, ni .. "Struct", opts(colours.orange))
  vim.api.nvim_set_hl(0, ni .. "Event", opts())
  vim.api.nvim_set_hl(0, ni .. "Operator", opts())
  vim.api.nvim_set_hl(0, ni .. "TypeParameter", opts(colours.green))
  vim.api.nvim_set_hl(0, "NavicText", opts())
  vim.api.nvim_set_hl(0, "NavicSeparator", opts(colours["light-grey"]))
end

function M.config()
  require("nvim-navic").setup({
    separator = " ",
    highlight = true,
    depth_limit = 3,
  })

  setup_colours()
end

return M
