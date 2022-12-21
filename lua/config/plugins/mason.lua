local M = {
  "williamboman/mason.nvim",

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
}

M.tools = {
  "black",
  "eslint_d",
  "flake8",
  "isort",
  "luacheck",
  "prettierd",
  "shellcheck",
  "shfmt",
  "stylua",
}

function M.check()
  local mr = require("mason-registry")
  for _, tool in ipairs(M.tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

function M.config()
  require("mason").setup()
  M.check()

  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "gopls",
      "jsonls",
      "pyright",
      "rust_analyzer",
      "sumneko_lua",
      "svelte",
      "taplo",
      "tsserver",
    },
  })
end

return M
