return {
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        return require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    lazy = true,
    keys = {
      {
        '<Down>',
        function()
          local ls = require('luasnip')
          if ls.jumpable(1) then
            ls.jump(1)
          else
            return '<Down>'
          end
        end,
        expr = true,
        silent = true,
        mode = { 'i', 's' },
      },
      {
        '<Up>',
        function()
          local ls = require('luasnip')
          if ls.expand_or_jumpable() then
            ls.jump(-1)
          else
            return '<Up>'
          end
        end,
        expr = true,
        silent = true,
        mode = { 'i', 's' },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    lazy = true,
    event = 'InsertEnter',
    opts = function()
      local cmp = require('cmp')
      local ls = require('luasnip')

      return {
        completion = { completeopt = 'menu,menuone,noinsert' },
        snippet = {
          expand = function(args)
            ls.lsp_expand(args.body)
          end,
        },
        enabled = function()
          local context = require('cmp.config.context')
          local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
          return buftype == ''
              and not context.in_treesitter_capture('comment')
              and not context.in_syntax_group('Comment')
            or not buftype == 'prompt'
        end,
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif ls.expand_or_jumpable() then
              ls.expand_or_jump()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif ls.jumpable(-1) then
              ls.jump(-1)
            else
              fallback()
            end
          end,
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-e>'] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path', trigger_characters = { '/' } },
        }),
        formatting = {
          format = function(_, item)
            local icons = require('icons').kinds
            if icons[item.kind] then
              item.kind = string.format('%s %s', icons[item.kind], item.kind)
            end
            return item
          end,
        },
        experimental = { ghost_text = { hl_group = '@comment' } },
      }
    end,
    config = function(_, opts)
      local cmp = require('cmp')
      cmp.setup(opts)

      cmp.event:on(
        'confirm_done',
        require('nvim-autopairs.completion.cmp').on_confirm_done()
      )

      local colours = require('colours')
      for name, hl in pairs({
        CmpItemAbbrDeprecated = { fg = colours.grey, strikethrough = true },
        CmpItemAbbrMatch = { fg = colours.neutral_blue, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = colours.neutral_blue, bold = true },
        CmpItemKindClass = { fg = colours.neutral_purple },
        CmpItemKindColor = { fg = colours.neutral_aqua },
        CmpItemKindConstant = { fg = colours.neutral_red },
        CmpItemKindConstructor = { fg = colours.neutral_red },
        CmpItemKindEnum = { fg = colours.neutral_green },
        CmpItemKindEnumMember = { fg = colours.neutral_yellow },
        CmpItemKindEvent = { fg = colours.bright_purple },
        CmpItemKindField = { fg = colours.neutral_yellow },
        CmpItemKindFile = { fg = colours.bright_purple },
        CmpItemKindFolder = { fg = colours.bright_purple },
        CmpItemKindFunction = { fg = colours.neutral_blue },
        CmpItemKindInterface = { fg = colours.neutral_aqua },
        CmpItemKindKeyword = { fg = colours.neutral_green },
        CmpItemKindMethod = { fg = colours.neutral_blue },
        CmpItemKindModule = { fg = colours.neutral_red },
        CmpItemKindOperator = { fg = colours.neutral_red },
        CmpItemKindProperty = { fg = colours.neutral_yellow },
        CmpItemKindReference = { fg = colours.neutral_red },
        CmpItemKindSnippet = { fg = colours.neutral_blue },
        CmpItemKindStruct = { fg = colours.neutral_purple },
        CmpItemKindText = { fg = colours.neutral_green },
        CmpItemKindTypeParameter = { fg = colours.neutral_aqua },
        CmpItemKindUnit = { fg = colours.neutral_yellow },
        CmpItemKindValue = { fg = colours.fg },
        CmpItemKindVariable = { fg = colours.fg },
        CmpItemMenu = { fg = colours.neutral_purple },
      }) do
        vim.api.nvim_set_hl(0, name, hl)
      end
    end,
  },
}
