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
      },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "chrisgrieser/cmp-nerdfont",
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

      local icons = {
        Text = " ",
        Method = " ",
        Function = " ",
        Constructor = " ",
        Field = " ",
        Variable = " ",
        Class = " ",
        Interface = " ",
        Module = " ",
        Property = " ",
        Unit = " ",
        Value = " ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      }

      local menu = {
        buffer = "(Buffer)",
        calc = "(Calc)",
        crates = "(Crates)",
        emoji = "(Emoji)",
        fish = "(Fish)",
        luasnip = "(LuaSnip)",
        nerdfont = "(NerdFont)",
        nvim_lsp = "(LSP)",
        nvim_lsp_document_symbol = "(LSP Doc)",
        nvim_lsp_signature_help = "(LSP Sig)",
        omni = "(Omni)",
        path = "(Path)",
      }

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
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s%s", icons[vim_item.kind], vim_item.kind)
            vim_item.abbr = vim_item.abbr:sub(0, 24)
            vim_item.menu = (menu)[entry.source.name]
            return vim_item
          end,
        },
        window = {
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          },
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

      local highlights = {
        PmenuSel = { fg = "NONE", bg = "#928374" },
        Pmenu = { fg = "#fbf1c7", bg = "#22252A" },

        CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
        CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
        CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
        CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },

        CmpItemKindText = { fg = "#C3E88D", bg = "NONE" },
        CmpItemKindEnum = { fg = "#C3E88D", bg = "NONE" },
        CmpItemKindKeyword = { fg = "#C3E88D", bg = "NONE" },

        CmpItemKindConstant = { fg = "#FB4934", bg = "NONE" },
        CmpItemKindConstructor = { fg = "#FB4934", bg = "NONE" },
        CmpItemKindReference = { fg = "#FB4934", bg = "NONE" },
        CmpItemKindOperator = { fg = "#FB4934", bg = "NONE" },
        CmpItemKindModule = { fg = "#FB4934", bg = "NONE" },

        CmpItemKindMethod = { fg = "#82AAFF", bg = "NONE" },
        CmpItemKindFunction = { fg = "#82AAFF", bg = "NONE" },

        CmpItemKindStruct = { fg = "#C792EA", bg = "NONE" },
        CmpItemKindClass = { fg = "#C792EA", bg = "NONE" },

        CmpItemKindVariable = { fg = "#FBF1C7", bg = "NONE" },
        CmpItemKindValue = { fg = "#FBF1C7", bg = "NONE" },

        CmpItemKindEvent = { fg = "#EED8DA", bg = "NONE" },
        CmpItemKindFolder = { fg = "#EED8DA", bg = "NONE" },
        CmpItemKindFile = { fg = "#DDE5F5", bg = "NONE" },

        CmpItemKindUnit = { fg = "#FABD2F", bg = "NONE" },
        CmpItemKindSnippet = { fg = "#FABD2F", bg = "NONE" },
        CmpItemKindEnumMember = { fg = "#FABD2F", bg = "NONE" },
        CmpItemKindField = { fg = "#FABD2F", bg = "NONE" },
        CmpItemKindProperty = { fg = "#FABD2F", bg = "NONE" },

        CmpItemKindInterface = { fg = "#458588", bg = "NONE" },
        CmpItemKindColor = { fg = "#458588", bg = "NONE" },
        CmpItemKindTypeParameter = { fg = "#458588", bg = "NONE" },
      }

      for name, hl in pairs(highlights) do
        vim.api.nvim_set_hl(0, name, hl)
      end
    end,
  },
  {
    "mtoohey31/cmp-fish",
    ft = "fish",
    config = function()
      local cmp = require("cmp")
      local completions = require("completions")
      cmp.setup.filetype("fish", {
        sources = cmp.config.sources(
          { { name = "fish" } },
          completions.lsp_sources,
          completions.sources
        ),
      })
    end,
  },
}
