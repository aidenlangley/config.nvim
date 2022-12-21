local M = {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
}

function M.init()
  local utils = require("utils")
  require("which-key").register({
    d = { utils.cmd("DiffviewOpen"), "[D]iff" },
    h = { utils.cmd("DiffviewFileHistory"), "File [H]istory" },
  }, { prefix = "<Leader>g" })
end

function M.config()
  require("diffview").setup({})
end

return M
