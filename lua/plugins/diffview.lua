local M = {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
  },
}

local function nmap(keys, func, desc)
  if desc then
    desc = "Git: " .. desc
  end

  vim.keymap.set("n", keys, func, { desc = desc })
end

function M.init()
  local utils = require("utils")
  nmap("<Leader>gd", utils.cmd("DiffviewOpen"), "[D]iff")
  nmap("<Leader>gh", utils.cmd("DiffviewFileHistory"), "[H]istory")
end

function M.config()
  require("diffview").setup({})
end

return M
