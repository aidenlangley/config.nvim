return {
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

      --- Check if the completion menu item is the only option
      ---@return boolean
      local function partially_complete()
        local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        local single_row = vim.api
          .nvim_buf_get_lines(0, row - 1, row, true)[1]
          :sub(col, col)
          :match("%s") == nil

        return col ~= 0 and single_row
      end

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
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif partially_complete() then
              cmp.complete()
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

          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
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
}
