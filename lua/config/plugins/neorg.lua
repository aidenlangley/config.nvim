local M = {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  cmd = "Neorg",
  ft = "norg",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}

function M.init() end

function M.config()
  require("neorg").setup({
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.completion"] = {
        config = { engine = "nvim-cmp" },
      },
      ["core.integrations.nvim-cmp"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            percy = "~/Notes/percy",
          },
        },
      },
    },
  })
end

return M
