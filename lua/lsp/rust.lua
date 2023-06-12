return {
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
      {
        'saecki/crates.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        init = function()
          vim.api.nvim_create_autocmd('BufRead', {
            group = vim.api.nvim_create_augroup(
              'CmpSourceCargo',
              { clear = true }
            ),
            pattern = 'Cargo.toml',
            callback = function()
              require('cmp').setup.buffer({
                sources = {
                  { name = 'crates' },
                },
              })
            end,
          })
        end,
        lazy = true,
        ft = 'rust',
        event = 'BufRead Cargo.toml',
        config = true,
      },
    },
    lazy = true,
    ft = 'rust',
    opts = {
      tools = { inlay_hints = { highlight = 'DevIconDefault' } },
    },
  },
}