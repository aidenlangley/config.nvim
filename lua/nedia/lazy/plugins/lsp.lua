---@diagnostic disable: no-unknown
return {

  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      ensure_installed = {
        'bashls',
        'dockerls',
        'jsonls',
        'lua_ls',
        'pyright',
        'taplo',
        'yamlls',
      },
    },
  },
  {
    'folke/neodev.nvim',
    config = true,
  },
  {
    'smjonas/inc-rename.nvim',
    main = 'inc_rename',
    config = true,
  },
  {
    'kosayoda/nvim-lightbulb',
    event = 'BufReadPost',
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true, text = '' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'smjonas/inc-rename.nvim',
      'kosayoda/nvim-lightbulb',
      'hrsh7th/cmp-nvim-lsp',
      'b0o/SchemaStore.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function(_, _)
      require('nedia.config.lsp')
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    ft = 'dart',
    config = true,
  },
  {
    'saecki/crates.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = 'BufRead Cargo.toml',
    config = true,
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    },
    ft = 'rust',
    opts = {
      tools = { inlay_hints = { highlight = 'DevIconDefault' } },
    },
  },
  {
    'https://git.sr.ht/~sircmpwn/hare.vim',
    dependencies = {
      'https://git.sr.ht/~torresjrjr/vim-haredoc',
    },
    ft = 'hare',
  },
}
