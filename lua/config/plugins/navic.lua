local M = {
  "SmiteshP/nvim-navic",
  enabled = false,

  requires = "neovim/nvim-lspconfig",
}

function M.config()
  vim.g.navic_silence = true

  require("nvim-navic").setup({
    separator = " ",
    highlight = true,
    depth_limit = 3,
  })
end

return M
