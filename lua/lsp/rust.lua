return {
  {
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    event = 'BufRead Cargo.toml',
    config = true,
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    },
    lazy = true,
    ft = 'rust',
    opts = {
      server = {
        on_attach = require('lsp._on_attach'),
        capabilities = require('lsp._capabilities'),
      },
      tools = { inlay_hints = { highlight = 'DevIconDefault' } },
    },
  },
}