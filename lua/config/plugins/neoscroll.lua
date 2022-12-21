local M = {
  "karb94/neoscroll.nvim",
  keys = {
    "<PageUp>",
    "<PageDown>",
    "<Home>",
    "<End>",
    "<ScrollWheelUp>",
    "<ScrollWheelDown>",
    "j",
    "k",
  },
}

function M.config()
  require("neoscroll").setup({
    -- mappings = M.keys,
    easing_function = "sine",
  })

  local mappings = {}
  mappings["<PageUp>"] = { "scroll", { "-vim.wo.scroll", "true", "254" } }
  mappings["<PageDown>"] = { "scroll", { "vim.wo.scroll", "true", "254" } }
  mappings["<Home>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "512" } }
  mappings["<End>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "512" } }
  mappings["<ScrollWheelUp>"] = { "scroll", { "-8", "true", "128" } }
  mappings["<ScrollWheelDown>"] = { "scroll", { "8", "true", "128" } }

  require("neoscroll.config").set_mappings(mappings)
end

return M