return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
      },
      keys = {
        {
          "<Leader>sm",
          require("utils").cmd("Mason"),
          desc = "Mason: Info",
        },
      },
    },
    opts = {
      ensure_installed = {
        "awklsp",
        "bashls",
        "jsonls",
        "lua_ls",
        "taplo",
        "vimls",
        "yamlls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      opts = { experimental = { pathStrict = true } },
    },
    ft = { "lua" },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              diagnostics = {
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
                arrayIndex = "Disable",
                setType = true,
              },
              telemetry = { enable = false },
              misc = { parameters = { "--loglevel=trace" } },
              format = { enable = true },
            },
          },
        },
      },
    },
  },
}
