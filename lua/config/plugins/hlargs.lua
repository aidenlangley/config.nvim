local M = {
  "m-demare/hlargs.nvim",
  event = "BufReadPost",
  enabled = false,

  requires = { "nvim-treesitter/nvim-treesitter" },
}

function M.config()
  require("hlargs").setup({
    excluded_argnames = {
      usages = {
        lua = { "self", "use" },
      },
    },
  })
end

return M
