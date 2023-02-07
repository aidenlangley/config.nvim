return {
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
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
        "gopls",
        "jsonls",
        "pyright",
        "rust_analyzer",
        "sumneko_lua",
        "svelte",
        "taplo",
        "tsserver",
        "vimls",
      },
      pip = { upgrade_pip = true },
    },
    config = function(_, opts)
      require("mason").setup()

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
      require("lspconfig").sumneko_lua.setup({
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
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
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead Cargo.toml",
    opts = {
      null_ls = {
        enabled = true,
        name = "crates",
      },
    },
  },
  {
    "jose-elias-alvarez/typescript.nvim",
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
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/lsp-colors.nvim",
      "b0o/SchemaStore.nvim",
    },
    event = "BufReadPre",
    keys = {
      {
        "<Leader>sl",
        require("utils").cmd("LspInfo"),
        desc = "LSP: Info",
      },
    },
    opts = {
      diagnostics = {
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
      ---@type LspHelper
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
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPost",
    opts = {
      ui = { border = "single" },
      beacon = { enable = false },
      diagnostic = {
        show_code_action = false,
        show_source = false,
        jump_num_shortcut = false,
      },
      lightbulb = {
        enable_in_insert = false,
        sign = false,
      },
      rename = { quit = "q" },
      symbol_in_winbar = { enable = false },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)

      local colours = require("config.colours").THEME
      vim.api.nvim_set_hl(0, "SagaBorder", { fg = colours.grey })
    end,
  },
}