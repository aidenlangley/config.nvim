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
        desc = "(N)ullLs: Info",
      },
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
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
            condition = function(utils)
              utils.root_has_file({ "node_modules" })
            end,
          }),
          null_ls.builtins.diagnostics.eslint.with({
            extra_filetypes = { "svelte" },
            prefer_local = "node_modules/.bin",
            condition = function(utils)
              utils.root_has_file({ "node_modules" })
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
    keys = {
      {
        "<Tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        mode = "i",
        expr = true,
        silent = true,
      },
      {
        "<Tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    version = false,
    event = "InsertEnter",
    opts = {
      completion = { completeopt = "menu,menuone,noinsert" },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      experimental = { ghost_text = { hl_group = "LspCodeLens" } },
      enabled = function()
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        else
          local context = require("cmp.config.context")
          return not context.in_treesitter_capture("comment")
            and not context.in_syntax_group("Comment")
        end
      end,
    },
    config = function(_, opts)
      local cmp = require("cmp")
      opts["sources"] = cmp.config.sources({
        { name = "buffer" },
        { name = "emoji" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
      })
      opts["mapping"] = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.scroll_docs(-4),
        ["<C-k>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })
      opts["formatting"] = {
        source_names = {},
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          menu = {
            buffer = "(Buffer)",
            emoji = "(Emoji)",
            luasnip = "(Lua)",
            nvim_lsp = "(LSP)",
            path = "(Path)",
          },
        }),
      }
      cmp.setup(opts)
    end,
  },
  {
    "echasnovski/mini.comment",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = { "gc" },
    opts = {
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        textobject = "gc",
      },
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
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
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Incremental re(n)ame",
      },
    },
    opts = {
      input_buffer_type = "dressing",
    },
  },
}
