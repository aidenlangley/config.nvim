local M = {
  "danth/pathfinder.vim",
  event = "BufEnter",
  enabled = false,
}

function M.config()
  vim.g.pf_popup_time = 1500
  vim.g.pf_autorun_delay = 0.5
end

return M
