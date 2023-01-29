local M = {
  "williamboman/mason.nvim",

  dependencies = { "williamboman/mason-lspconfig.nvim" },
}

local tools = {
  "black",
  "commitlint",
  "eslint_d",
  "flake8",
  "gofumpt",
  "golines",
  "isort",
  "luacheck",
  "prettierd",
  "shellcheck",
  "shfmt",
  "stylua",
}

local function check()
  local registry = require("mason-registry")
  for _, tool in ipairs(tools) do
    local pkg = registry.get_package(tool)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

function M.config()
  require("mason").setup()
  check()

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
    pip = { upgrade_pip = true },
  })

  vim.keymap.set("n", "<Leader>sm", require("utils").cmd("Mason"), { desc = "Mason" })
end

return M
