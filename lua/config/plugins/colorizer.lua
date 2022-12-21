local M = {
  "norcalli/nvim-colorizer.lua",
  event = "BufReadPre",
}

function M.config()
  require("colorizer").setup({}, { mode = "background" })
end

return M
