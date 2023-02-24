return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {
      "css",
      "graphql",
      "handlebars",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "less",
      "markdown",
      "scss",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
    },
    keys = {
      {
        "<Leader>sn",
        require("utils").cmd("NullLsInfo"),
        desc = "NullLs: Info",
      },
    },
    opts = function()
      local null_ls = require("null-ls")

      local function has_package_json(utils)
        return utils.root_has_file({ "package.json" })
      end

      return {
        debounce = 150,
        sources = {
          -- Web dev - other tools that are generally only used for a single
          -- filetype should be defined in `after/ftplugin` and registered via
          -- `utils.register_null_ls_source`.
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "css",
              "graphql",
              "handlebars",
              "html",
              "javascript",
              "javascriptreact",
              "json",
              "jsonc",
              "less",
              "scss",
              "typescript",
              "typescriptreact",
              "vue",
            },
            only_local = "node_modules/.bin",
            condition = has_package_json,
          }),
          null_ls.builtins.diagnostics.eslint.with({
            only_local = "node_modules/.bin",
            condition = has_package_json,
          }),
          null_ls.builtins.code_actions.eslint.with({
            only_local = "node_modules/.bin",
            condition = has_package_json,
          }),
        },
        diagnostics_format = "[#{c}] #{m} (#{s})",
      }
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<Leader>rf",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        desc = "Re(f)actor...",
      },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<Leader>rn",
        require("utils").cmd("IncRename " .. vim.fn.expand("<cword>")),
        expr = true,
        desc = "Incremental re(n)ame",
      },
    },
    opts = { input_buffer_type = "dressing" },
  },
}
