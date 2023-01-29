local M = {
  "folke/zen-mode.nvim",
  cmd = { "ZenMode" },

  dependencies = {
    "folke/twilight.nvim",
  },
}

function M.init()
  vim.keymap.set("n", "<S-z>", require("utils").cmd("ZenMode"), { desc = "ZenMode" })
end

function M.config()
  require("zen-mode").setup()
end

return M
