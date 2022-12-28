local M = {
  "akinsho/toggleterm.nvim",
  keys = "<C-t>",
}

function M.config()
  require("toggleterm").setup({
    open_mapping = "<C-t>",
    direction = "horizontal",
    size = 12,
    persist_size = true,
    hide_numbers = true,
    start_in_insert = true,
  })
end

return M
