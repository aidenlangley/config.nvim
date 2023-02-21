return {
  {
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
    config = function()
      require("mason").setup()

      local tools = {
        "black",
        "csharpier",
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

      local registry = require("mason-registry")
      for _, tool in ipairs(tools) do
        local pkg = registry.get_package(tool)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "bashls",
        "csharp_ls",
        "cssls",
        "denols",
        "dockerls",
        "emmet_ls",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "taplo",
        "tsserver",
        "vimls",
        "yamlls",
      },
      pip = { upgrade_pip = true },
    },
  },
  {
    "folke/neodev.nvim",
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    ft = "lua",
    config = function()
      require("neodev").setup()

      require("lspconfig").lua_ls.setup({
        capabilities = require("lsp").capabilities,
        on_attach = function(client, bufnr)
          require("config.keymaps").lsp(client, bufnr)

          local cmp = require("cmp")
          cmp.setup.filetype("lua", {
            sources = cmp.config.sources({
              { name = "luasnip" },
            }, require("completions").sources),
          })
        end,
        single_file_support = true,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            completion = {
              autoRequired = true,
              displayContext = 1,
            },
            codeLens = { enable = 1 },
            hint = { enable = true },
            telemetry = { enable = false },
          },
        },
      })
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    opts = function()
      local rt = require("rust-tools")
      return {
        tools = { hover_actions = { border = "none" } },
        server = {
          on_attach = function(client, bufnr)
            require("lsp").on_attach(client, bufnr)
            rt.inlay_hints.enable()

            vim.keymap.set(
              "n",
              "<C-.>",
              rt.code_action_group.code_action_group,
              { desc = "Code actions..." }
            )
            vim.keymap.set(
              "n",
              "<C-a>",
              rt.hover_actions.hover_actions,
              { desc = "Hover actions..." }
            )
          end,
          standalone = true,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
              inlayHints = { locationLinks = false },
            },
          },
        },
      }
    end,
  },
  {
    "Saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead Cargo.toml",
    opts = {
      null_ls = {
        enabled = true,
        name = "crates",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("InsertEnter", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          local cmp = require("cmp")
          local completions = require("completions")
          cmp.setup.buffer({
            sources = cmp.config.sources({
              { name = "crates" },
            }, completions.sources),
          })
        end,
      })
    end,
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    dependencies = { "jose-elias-alvarez/null-ls.nvim" },
    ft = "typescript",
    opts = {
      server = {
        on_attach = function(client, bufnr)
          require("lsp").on_attach(client, bufnr)
          require("utils").register_null_ls_source(
            -- https://github.com/jose-elias-alvarez/typescript.nvim#null-ls
            require("typescript.extensions.null-ls.code-actions")
          )
        end,
        root_dir = function()
          require("lspconfig").util.root_pattern("package.json")
        end,
      },
    },
  },
  "akinsho/flutter-tools.nvim",
  { "evanleck/vim-svelte", ft = "svelte" },
  { "fladson/vim-kitty", ft = "kitty" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      --
      -- Completions
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",

      -- JSON
      "b0o/SchemaStore.nvim",

      -- Utility
      "folke/lsp-colors.nvim",
      "j-hui/fidget.nvim",
    },
    keys = {
      {
        "<Leader>sl",
        require("utils").cmd("LspInfo"),
        desc = "LSP: Info",
      },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      },
      servers = {
        jsonls = {
          on_new_config = function(config)
            config.settings.json["schemas"] = config.settings.json.schemas or {}
            ---@diagnostic disable-next-line: missing-parameter
            vim.list_extend(
              config.settings.json.schemas,
              require("schemastore").json.schemas()
            )
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
        gopls = { settings = { gofumpt = true } },
        denols = {
          root_dir = function()
            require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")
          end,
        },
      },
    },
    config = function(_, opts)
      local lsp = require("lsp")
      local capabilities = lsp.capabilities
      local on_attach = lsp.on_attach

      ---@type table
      local handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
      }

      ---@param server string
      ---@param config table<string, any>
      for server, config in pairs(opts.servers) do
        config["capabilities"] = capabilities
        config["on_attach"] = on_attach

        ---@type fun(server_name?: string)
        handlers[server] = function(_server_name)
          require("lspconfig")[server].setup(config)
        end
      end

      vim.diagnostic.config(opts.diagnostics)
      require("mason-lspconfig").setup_handlers(handlers)

      require("fidget").setup({})
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      {
        "<Leader>S",
        require("utils").cmd("SymbolsOutline"),
        desc = "LSP: [S]ymbols",
      },
    },
    config = true,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = { "BufReadPost" },
    opts = { autocmd = { enabled = true } },
  },
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<Leader>t",
        require("utils").cmd("Trouble"),
        desc = "[T]rouble (diagnostics)",
      },
    },
  },
}
