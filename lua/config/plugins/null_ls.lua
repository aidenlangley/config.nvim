local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPost",
}

function M.config()
  local function node_filter(utils)
    return utils.root_has_file({ "node_modules" })
  end

  local nls = require("null-ls")
  nls.setup({
    sources = {
      -- Lua
      nls.builtins.formatting.stylua,
      nls.builtins.diagnostics.luacheck.with({
        extra_args = { "--config", ".luacheckrc" },
      }),
      -- Web dev
      nls.builtins.formatting.prettierd.with({
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "css",
          "scss",
          "less",
          "html",
          "json",
          "jsonc",
          -- "yaml",
          -- "markdown",
          "markdown.mdx",
          "graphql",
          "handlebars",
        },
        only_local = "node_modules/.bin",
        condition = node_filter,
      }),
      nls.builtins.diagnostics.eslint_d.with({
        prefer_local = "node_modules/.bin",
        condition = node_filter,
      }),
      -- https://github.com/jose-elias-alvarez/typescript.nvim#null-ls
      require("typescript.extensions.null-ls.code-actions"),
      -- CSS linter
      nls.builtins.diagnostics.stylelint.with({
        only_local = "node_modules/.bin",
        condition = node_filter,
      }),
      -- Fish
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.fish,
      -- Git commits
      nls.builtins.diagnostics.commitlint,
      -- Go
      nls.builtins.formatting.gofumpt,
      nls.builtins.formatting.golines.with({
        extra_args = { "-m", "80", "-t", "2", "--base-formatter", "gofumpt" },
      }),
      -- Python
      nls.builtins.formatting.black.with({
        args = { "--line-length", "79" },
      }),
      nls.builtins.formatting.isort,
      nls.builtins.diagnostics.flake8,
      -- Shell
      nls.builtins.formatting.shfmt,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.code_actions.shellcheck,
      -- Yaml
      nls.builtins.formatting.prettierd.with({
        extra_filetypes = { "yaml", "yml" },
        args = { "--no-bracket-spacing" },
      }),
      nls.builtins.diagnostics.yamllint,
      -- Markdown
      nls.builtins.formatting.prettierd.with({
        filetypes = { "markdown" },
      }),
    },
    diagnostics_format = "[#{c}] #{m} (#{s})",
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
  })

  vim.keymap.set("n", "<Leader>sn", require("utils").cmd("NullLsInfo"), { desc = "null-ls info" })
end

return M
