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
    opts = {
      debug = true,
      experimental = { pathStrict = true },
    },
    config = function(_, opts)
      require("neodev").setup(opts)

      require("lspconfig").lua_ls.setup({
        capabilities = require("lsp").capabilities,
        on_attach = require("lsp").on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            diagnostics = {
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
              libraryFiles = "Enable",
              workspaceRate = 65,
            },
            completion = {
              workspaceWord = true,
              callSnippet = "Replace",
            },
            hint = {
              enable = true,
              arrayIndex = "Disable",
              setType = true,
            },
            telemetry = { enable = false },
            misc = { parameters = { "--loglevel=trace" } },
            format = { enable = false },
          },
        },
      })
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    opts = {
      tools = {
        inlay_hints = { auto = false },
        hover_actions = { border = "none" },
      },
      server = {
        capabilities = require("lsp").capabilities,
        on_attach = function(client, bufnr)
          require("lsp").on_attach(client, bufnr)

          local rt = require("rust-tools")
          vim.keymap.set(
            "n",
            "<C-.>",
            rt.code_action_group.code_action_group,
            { desc = "Code actions...", buffer = bufnr }
          )
          vim.keymap.set(
            "n",
            "<C-a>",
            rt.hover_actions.hover_actions,
            { desc = "Hover actions...", buffer = bufnr }
          )
        end,
        standalone = false,
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
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "svelte",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    opts = {
      server = {
        capabilities = require("lsp").capabilities,
        on_attach = function(client, bufnr)
          require("lsp").on_attach(client, bufnr)

          vim.keymap.set(
            "n",
            "gd",
            require("utils").cmd("TypescriptGoToSourceDefinition"),
            { desc = "Goto (D)efinition", buffer = bufnr }
          )

          client.server_capabilities.documentFormattingProvider = false
        end,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "svelte",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          initializationOptions = {
            preferences = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            },
          },
        },
      },
    },
  },
  "akinsho/flutter-tools.nvim",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "b0o/SchemaStore.nvim",
      "folke/lsp-colors.nvim",
      { "j-hui/fidget.nvim", config = true },
      {
        "lvimuser/lsp-inlayhints.nvim",
        config = function(_, opts)
          require("lsp-inlayhints").setup(opts)
          vim.api.nvim_set_hl(0, "LspInlayHint", { link = "@comment" })
        end,
      },
    },
    event = { "BufReadPre" },
    keys = {
      {
        "<Leader>sl",
        require("utils").cmd("LspInfo"),
        desc = "LSP = false, Info",
      },
    },
    opts = function()
      local lsp_util = require("lspconfig").util

      return {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        },
        servers = {
          denols = {
            root_dir = function(fname)
              return lsp_util.root_pattern("deno.json*")(fname)
            end,
          },
          gopls = { settings = { gofumpt = true } },
          jsonls = {
            on_new_config = function(config)
              config.settings.json["schemas"] = config.settings.json.schemas
                or {}
              ---@diagnostic disable-next-line = false, missing-parameter
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
          svelte = {
            settings = {
              initializationOptions = {
                configuration = {
                  svelte = {
                    plugin = {
                      typescript = { semanticTokens = { enable = false } },
                    },
                  },
                },
                preferences = {
                  includeInlayEnumMemberValueHints = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                },
              },
              typescript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                },
              },
            },
          },
          tailwindcss = {
            root_dir = function(fname)
              return lsp_util.root_pattern("tailwind.config.*")(fname)
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      local lsp = require("lsp")
      local on_attach = lsp.on_attach
      local capabilities = lsp.capabilities

      ---@type table
      local handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
      }

      ---@param server string
      ---@param config table<string, any>
      for server, config in pairs(opts.servers) do
        config["on_attach"] = config["on_attach"] or on_attach
        config["capabilities"] = config["capabilities"] or capabilities

        ---@type fun(server_name?, string)
        handlers[server] = function(server_name)
          require("lspconfig")[server_name].setup(config)
        end
      end

      vim.diagnostic.config(opts.diagnostics)
      require("mason-lspconfig").setup_handlers(handlers)
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      {
        "<Leader>S",
        require("utils").cmd("SymbolsOutline"),
        desc = "LSP = false, [S]ymbols",
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
