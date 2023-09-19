return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = 'dart',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    opts = {
      lsp = {
        on_attach = require('lsp._on_attach'),
        capabilities = require('lsp._capabilities'),
      },
    },
  },
}