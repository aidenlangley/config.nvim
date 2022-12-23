local M = {
  "sainnhe/gruvbox-material",
  event = "VimEnter",
}

function M.config()
  vim.o.background = "dark"
  vim.g.gruvbox_material_background = "hard"
  vim.cmd([[colorscheme gruvbox-material]])
end

return M
