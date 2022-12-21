local M = {
  "ggandor/leap.nvim",
  event = "BufReadPost",
}

function M.config()
  require("leap").set_default_keymaps()
end

return M
