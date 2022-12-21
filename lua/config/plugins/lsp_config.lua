local M = {
  "neovim/nvim-lspconfig",
  name = "lsp_config",
  event = "BufReadPre",

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
}

function M.on_attach(client, bufnr)
  require("config.keymaps").lsp(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

function M.config()
  M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

  require("mason-lspconfig").setup_handlers({
    -- Default handler
    M.default_handler,
    ["gopls"] = M.gopls,
    ["jsonls"] = M.gopls,
    ["rust_analyzer"] = M.rust_analyzer,
    ["sumneko_lua"] = M.sumneko_lua,
    ["volar"] = M.volar,
  })

  require("fidget").setup()
end

function M.default_handler(server_name)
  require("lspconfig")[server_name].setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
end

function M.gopls()
  require("lspconfig").gopls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  })
end

function M.jsonls()
  require("lspconfig").jsonls.setup({
    settings = {
      json = {
        format = { enable = true },
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
end

function M.rust_analyzer()
  local rt = require("rust-tools")
  rt.setup({
    tools = {
      hover_actions = {
        border = "none",
      },
    },
    server = {
      on_attach = function(client, bufnr)
        require("config.keymaps").lsp(client, bufnr)

        require("which-key").register({
          A = { rt.code_action_group.code_action_group, "Code [A]ction group" },
          e = { rt.expand_macro.expand_macro, "[E]xpand macro" },
          h = { rt.hover_actions.hover_actions, "[H]over actions" },
        }, { prefix = "<Leader>c" })
      end,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
        },
      },
    },
  })
end

function M.sumneko_lua()
  local runtime_path = vim.split(package.path, ";", {})
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  require("lspconfig").sumneko_lua.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
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

function M.volar()
  require("lspconfig").volar.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "json",
    },
  })
end

return M
