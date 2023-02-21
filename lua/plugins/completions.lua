return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
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
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      --- Check if the completion menu item is the only option
      ---@return boolean
      local function partially_complete()
        unpack = unpack or table.unpack
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local single_row = vim.api
          .nvim_buf_get_lines(0, row - 1, row, true)[1]
          :sub(col, col)
          :match("%s") == nil

        return col ~= 0 and single_row
      end

      return {
        completion = { completeopt = "menuone,noinsert,noselect" },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        enabled = function()
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            local context = require("cmp.config.context")
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end
        end,
        sources = require("completions").sources,
        formatting = {
          source_names = {},
          format = require("lspkind").cmp_format({
            maxwidth = 32,
            mode = "symbol_text",
            menu = {
              buffer = "(Buffer)",
              calc = "(Calc)",
              crates = "(Crates)",
              emoji = "(Emoji)",
              fish = "(Fish)",
              luasnip = "(LuaSnip)",
              nvim_lsp = "(LSP)",
              nvim_lsp_document_symbol = "(LSP Doc)",
              nvim_lsp_signature_help = "(LSP Sig)",
              omni = "(Omni)",
              path = "(Path)",
            },
          }),
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

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
        experimental = { ghost_text = { hl_group = "@comment" } },
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
          { name = "cmdline" },
        }),
      })

      local autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", autopairs.on_confirm_done())
    end,
  },
  {
    "mtoohey31/cmp-fish",
    dependencies = { "hrsh7th/nvim-cmp" },
    ft = "fish",
    config = function()
      local cmp = require("cmp")
      local sources = cmp.get_config().sources
      sources[#sources + 1] = cmp.config.sources({
        { name = "fish" },
      })
    end,
  },
}
