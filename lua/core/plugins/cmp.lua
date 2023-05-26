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
            return ls.jump(1)
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
            return ls.jump(-1)
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
    version = false, -- last release is way too old
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
          ['<Tab>'] = function()
            if cmp.visible() then
              cmp.select_next_item()
            elseif ls.expand_or_jumpable() then
              ls.expand_or_jump()
            end
          end,
          ['<S-Tab>'] = function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif ls.jumpable(-1) then
              ls.jump(-1)
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
              item.kind = icons[item.kind] .. item.kind
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
        CmpItemAbbrMatch = { fg = colours.blue, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = colours.blue, bold = true },
        CmpItemKindClass = { fg = colours.purple },
        CmpItemKindColor = { fg = colours.teal },
        CmpItemKindConstant = { fg = colours.red },
        CmpItemKindConstructor = { fg = colours.red },
        CmpItemKindEnum = { fg = colours.green },
        CmpItemKindEnumMember = { fg = colours.yellow },
        CmpItemKindEvent = { fg = colours.brpink },
        CmpItemKindField = { fg = colours.yellow },
        CmpItemKindFile = { fg = colours.brpurple },
        CmpItemKindFolder = { fg = colours.brpink },
        CmpItemKindFunction = { fg = colours.blue },
        CmpItemKindInterface = { fg = colours.teal },
        CmpItemKindKeyword = { fg = colours.green },
        CmpItemKindMethod = { fg = colours.blue },
        CmpItemKindModule = { fg = colours.red },
        CmpItemKindOperator = { fg = colours.red },
        CmpItemKindProperty = { fg = colours.yellow },
        CmpItemKindReference = { fg = colours.red },
        CmpItemKindSnippet = { fg = colours.blue },
        CmpItemKindStruct = { fg = colours.purple },
        CmpItemKindText = { fg = colours.green },
        CmpItemKindTypeParameter = { fg = colours.teal },
        CmpItemKindUnit = { fg = colours.yellow },
        CmpItemKindValue = { fg = colours.fg },
        CmpItemKindVariable = { fg = colours.fg },
        CmpItemMenu = { fg = colours.purple },
        Pmenu = { fg = colours.fg, bg = colours.bg },
        PmenuSel = { bg = colours.brbg },
      }) do
        vim.api.nvim_set_hl(0, name, hl)
      end
    end,
  },
}