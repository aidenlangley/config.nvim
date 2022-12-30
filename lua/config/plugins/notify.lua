local M = {
  "rcarriga/nvim-notify",
  lazy = false,
}

function M.init()
  local notify = require("notify")
  notify.setup({
    level = vim.log.levels.INFO,
    fps = 20,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  })

  vim.notify = notify
end

return M
