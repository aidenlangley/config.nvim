local M = {
  "karb94/neoscroll.nvim",
  keys = {
    "<C-u>",
    "<C-d>",
    "<PageUp>",
    "<PageDown>",
    "<Home>",
    "<End>",
    "<ScrollWheelUp>",
    "<ScrollWheelDown>",
  },
}

function M.config()
  require("neoscroll").setup({
    mappings = M.keys,
    easing_function = "sine",
  })

  local mappings = {}
  mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "254" } }
  mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "254" } }
  mappings["<PageUp>"] = { "scroll", { "-vim.wo.scroll", "true", "254" } }
  mappings["<PageDown>"] = { "scroll", { "vim.wo.scroll", "true", "254" } }
  mappings["<Home>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "512" } }
  mappings["<End>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "512" } }
  mappings["<ScrollWheelUp>"] = { "scroll", { "-12", "true", "128" } }
  mappings["<ScrollWheelDown>"] = { "scroll", { "12", "true", "128" } }

  require("neoscroll.config").set_mappings(mappings)
end

return M
