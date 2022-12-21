local M = {
  "akinsho/nvim-bufferline.lua",
  event = "BufReadPre",
  enabled = false,
}

function M.config()
  require("bufferline").setup()
end

return M
