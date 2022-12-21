local M = {
  "folke/which-key.nvim",
}

function M.config()
  local wk = require("which-key")
  wk.setup({
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
      ["<backspace>"] = "<-",
      ["<Backspace>"] = "<-",
    },
  })

  wk.register({
    { ["<Backspace>"] = { name = "Show all..." } },
  }, { prefix = "<Leader>", mode = { "n", "v" } })
end

return M
