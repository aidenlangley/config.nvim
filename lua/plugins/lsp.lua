return {
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
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
    config = function(_, opts)
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

      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "folke/neodev.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "saadparwaiz1/cmp_luasnip",
    },
    ft = "lua",
    opts = {
      debug = true,
      experimental = { pathStrict = true },
      setup_jsonls = true,
    },
    config = function(_, opts)
      require("neodev").setup(opts)

      local runtime_path = vim.split(package.path, ";", {})
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      local lsp = require("lsp")
      require("lspconfig").lua_ls.setup({
        capabilities = lsp.capabilities,
        on_attach = function(client, bufnr)
          require("config.keymaps").lsp(client, bufnr)

          local cmp = require("cmp")
          local completions = require("completions")
          cmp.setup.buffer({
            sources = cmp.config.sources({
              { name = "luasnip" },
            }, completions.lsp_sources, completions.sources),
          })
        end,
        single_file_support = true,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = runtime_path,
            },
            completion = {
              workspaceWord = true,
              callSnippet = "Both",
            },
            misc = {
              parameters = {
                "--log-level=trace",
              },
            },
            diagnostics = {
              globals = { "vim" },
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
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                continuation_indent_size = "2",
              },
            },
            telemetry = { enable = false },
          },
        },
      })
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    opts = {
      tools = { hover_actions = { border = "none" } },
      server = {
        on_attach = function(client, bufnr)
          require("lsp").on_attach(client, bufnr)
          require("rust-tools").inlay_hints.enable()
        end,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            inlayHints = { locationLinks = false },
          },
        },
      },
    },
  },
  {
    "Saecki/crates.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
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
            }, completions.lsp_sources, completions.sources),
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
  { "dag/vim-fish", ft = "fish" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- JSON
      "b0o/SchemaStore.nvim",

      -- Utility
      "folke/lsp-colors.nvim",
      "j-hui/fidget.nvim",

      -- Completions
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
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
            vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
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
        config["on_attach"] = on_attach
        config["capabilities"] = capabilities

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
