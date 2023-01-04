local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local wk = require("which-key")
  wk.setup({
    plugins = {
      presets = {
        operators = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = false,
      },
    },
    key_labels = {
      ["<leader>"] = "SPC",
      ["<Leader>"] = "SPC",
      ["<space>"] = "SPC",
      ["<Space>"] = "SPC",
      ["<c-space>"] = "C-SPC",
      ["<C-Space>"] = "C-SPC",
      ["<cr>"] = "CR",
      ["<CR>"] = "CR",
      ["<tab>"] = "TAB",
      ["<Tab>"] = "TAB",
      ["<s-tab>"] = "S-TAB",
      ["<S-Tab>"] = "S-TAB",
      ["<bs>"] = "<-",
      ["<BS>"] = "<-",
    },
  })

  wk.register({
    { ["<BS>"] = { name = "Show all..." } },
  }, { prefix = "<Leader>", mode = { "n", "v" } })
end

return M
