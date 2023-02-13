return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {
      "css",
      "graphql",
      "handlebars",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "less",
      "markdown.mdx",
      "scss",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
    },
    keys = {
      {
        "<Leader>sn",
        require("utils").cmd("NullLsInfo"),
        desc = "NullLs: Info",
      },
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debounce = 150,
        sources = {
          -- Web dev
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "css",
              "graphql",
              "handlebars",
              "html",
              "javascript",
              "javascriptreact",
              "json",
              "jsonc",
              "less",
              "markdown.mdx",
              "scss",
              "svelte",
              "typescript",
              "typescriptreact",
              "vue",
            },
            only_local = "node_modules/.bin",
            condition = function(nls_utils)
              nls_utils.root_has_file({ "node_modules" })
            end,
          }),
          null_ls.builtins.diagnostics.eslint.with({
            extra_filetypes = { "svelte" },
            prefer_local = "node_modules/.bin",
            condition = function(nls_utils)
              nls_utils.root_has_file({ "node_modules" })
            end,
          }),
          require("typescript.extensions.null-ls.code-actions").with({
            extra_filetypes = { "svelte", "vue" },
          }),
        },
        diagnostics_format = "[#{c}] #{m} (#{s})",
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    build = "make install_jsregexp",
    opts = { history = true },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    version = false,
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      return {
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        experimental = { ghost_text = { hl_group = "@comment" } },
        enabled = function()
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            local context = require("cmp.config.context")
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end
        end,
        sources = cmp.config.sources({
          { name = "crates" },
          { name = "omni" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp_document_symbol" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "emoji" },
        }),
        mapping = {
          ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<Down>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),

          ["<CR>"] = cmp.mapping(
            cmp.mapping.confirm({
              select = true,
            }),
            { "i", "s" }
          ),
        },
        formatting = {
          source_names = {},
          format = require("lspkind").cmp_format({
            maxwidth = 32,
            mode = "symbol_text",
            menu = {
              buffer = "(Buffer)",
              emoji = "(Emoji)",
              luasnip = "(LuaSnip)",
              nvim_lsp = "(LSP)",
              nvim_lsp_signature_help = "(Signature)",
              nvim_lsp_document_symbol = "(Document)",
              omni = "(Omni)",
              path = "(Path)",
              crates = "(Crates)",
            },
          }),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      local autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", autopairs.on_confirm_done())
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<Leader>rf",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        desc = "Re(f)actor...",
      },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<Leader>rn",
        require("utils").cmd("IncRename " .. vim.fn.expand("<cword>")),
        expr = true,
        desc = "Incremental re(n)ame",
      },
    },
    opts = { input_buffer_type = "dressing" },
  },
}
