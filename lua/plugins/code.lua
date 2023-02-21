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
      "markdown.mdx",
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
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debounce = 150,
        sources = {
          -- Web dev
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
              "markdown.mdx",
              "scss",
              "svelte",
              "typescript",
              "typescriptreact",
              "vue",
            },
            only_local = "node_modules/.bin",
            condition = function(nls_utils)
              nls_utils.root_has_file({ "node_modules" })
            end,
          }),
          null_ls.builtins.diagnostics.eslint.with({
            extra_filetypes = { "svelte" },
            prefer_local = "node_modules/.bin",
            condition = function(nls_utils)
              nls_utils.root_has_file({ "node_modules" })
            end,
          }),
          null_ls.builtins.code_actions.eslint.with({
            extra_filetypes = { "svelte" },
            prefer_local = "node_modules/.bin",
            condition = function(nls_utils)
              nls_utils.root_has_file({ "node_modules" })
            end,
          }),
          require("typescript.extensions.null-ls.code-actions").with({
            extra_filetypes = { "svelte", "vue" },
          }),
        },
        diagnostics_format = "[#{c}] #{m} (#{s})",
      })
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
