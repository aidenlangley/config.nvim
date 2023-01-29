local M = {
  "neovim/nvim-lspconfig",
  name = "lsp_config",
  event = "BufReadPre",

  dependencies = {
    "williamboman/mason.nvim",
    "folke/lsp-colors.nvim",
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(client, bufnr)
  require("config.keymaps").lsp(client, bufnr)

  local navic_ok, navic = pcall(require, "nvim-navic")
  if navic_ok then
    navic.attach(client, bufnr)
  end
end

local function default_handler(server_name)
  require("lspconfig")[server_name].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

local function gopls()
  require("lspconfig").gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  })
end

local function jsonls()
  require("lspconfig").jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        format = { enable = true },
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
end

local function rust_analyzer()
  local rt = require("rust-tools")
  rt.setup({
    tools = {
      hover_actions = {
        border = "none",
      },
    },
    server = {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        rt.inlay_hints.enable()
      end,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
          inlayHints = { locationLinks = false },
        },
      },
    },
  })
end

local function sumneko_lua()
  require("neodev").setup()

  local runtime_path = vim.split(package.path, ";", {})
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  require("lspconfig").sumneko_lua.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = runtime_path,
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      },
    },
  })
end

local function volar()
  require("lspconfig").volar.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
    },
  })
end

function M.config()
  capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

  require("mason-lspconfig").setup_handlers({
    -- Default handler
    default_handler,
    ["gopls"] = gopls,
    ["jsonls"] = jsonls,
    ["rust_analyzer"] = rust_analyzer,
    ["sumneko_lua"] = sumneko_lua,
    -- ["volar"] = volar,
  })

  local fidget_ok, fidget = pcall(require, "fidget")
  if fidget_ok then
    fidget.setup()
  end
end

return M
