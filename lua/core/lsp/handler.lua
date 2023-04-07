return {
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspLog", "LspStart", "LspStop", "LspRestart" },
    keys = {
      {
        "<Leader>sl",
        require("utils").cmd("LspInfo"),
        desc = "LSP: View info",
      },
      {
        "<Leader>sO",
        require("utils").cmd("LspLog"),
        desc = "LSP: Open log",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre" },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      },
      on_attach = function()
        require("core.lsp.keymaps")
      end,
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      servers = { lua_ls = {} }
    },
    config = function(_, opts)
      if opts.server then
        vim.notify(vim.inspect(opts))
      end

      vim.diagnostic.config(opts.diagnostics)

      ---@type fun(server_name: string)[] | table<string, any>
      local handlers = {
        -- This is the default handler
        function(server_name)
          require("lspconfig")[server_name].setup({
            ---@module "core.lsp.keymaps"
            ---@type LspClientKeymaps
            on_attach = opts.on_attach,
            ---@type table
            capabilities = opts.capabilities,
          })
        end,
      }

      ---@param name string
      ---@param config table<string, any> | boolean | nil
      for name, config in pairs(opts.servers or {}) do
        if config then
          -- Now we merge servers that are defined to ensure they have
          -- `on_attach` and `capabilities`, and we're not repeating ourselves.
          config["on_attach"] = config.on_attach or opts.on_attach
          config["capabilities"] = config.capabilities or opts.capabilities

          handlers[name] = function(server_name)
            require("lspconfig")[server_name].setup(config)
          end
        end
      end

      require("mason-lspconfig").setup_handlers(handlers)
    end,
  },
}
