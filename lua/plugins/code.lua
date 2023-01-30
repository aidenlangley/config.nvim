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
    build = "make install_jsregexp",
    opts = { history = true },
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
      local luasnip = require("luasnip")

      local function select_next_item(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end

      local function select_prev_item(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end

      opts["sources"] = cmp.config.sources({
        { name = "buffer" },
        { name = "emoji" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "crates" },
      })
      opts["mapping"] = {
        ["<Tab>"] = cmp.mapping(select_next_item, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(select_prev_item, { "i", "s" }),
        ["<Down>"] = cmp.mapping(select_next_item, { "i", "s" }),
        ["<Up>"] = cmp.mapping(select_prev_item, { "i", "s" }),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "s" }),
      }
      opts["formatting"] = {
        source_names = {},
        format = require("lspkind").cmp_format({
          maxwidth = 32,
          mode = "symbol_text",
          menu = {
            buffer = "(Buffer)",
            emoji = "(Emoji)",
            luasnip = "(LuaSnip)",
            nvim_lsp = "(LSP)",
            path = "(Path)",
            crates = "(Crates)",
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
