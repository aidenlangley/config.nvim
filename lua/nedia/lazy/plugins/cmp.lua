return {
  {
    'L3MON4D3/LuaSnip',
    config = true,
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'windwp/nvim-autopairs',
    },
    config = function(_, _)
      require('nedia.config.cmp')
    end,
  },
}
