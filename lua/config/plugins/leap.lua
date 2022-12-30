local M = {
  "ggandor/leap.nvim",
  event = "VeryLazy",
}

function M.config()
  require("leap").set_default_keymaps()
end

return M
