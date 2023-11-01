return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        'black',
        'isort',
        'luacheck',
        'prettier',
        'shfmt',
        'stylua',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)

      local registry = require('mason-registry')
      registry:on('package:install:success', function()
        vim.defer_fn(function()
          -- Trigger FileType event to load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      local function ensure_installed()
        ---@param tool string
        for _, tool in ipairs(opts.ensure_installed) do
          local p = registry.get_package(tool)
          if not p:is_installed() then
            p:install()
            require('logger').trace(
              string.format('Mason installed %s ', tool)
            )
          end
        end
      end

      if registry.refresh then
        registry.refresh(ensure_installed)
      else
        ensure_installed()
      end

      local utils = require('nedia.utils')
      utils.leader('n', 'ma', utils.cmd('Mason'), { desc = 'Mason' })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        'bashls',
        'dockerls',
        'gopls',
        'jsonls',
        'lua_ls',
        'pyright',
        'taplo',
        'yamlls',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function(_, _)
      require('nedia.config.lsp')
    end,
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
  'b0o/SchemaStore.nvim',
  {
    'folke/neodev.nvim',
    ft = 'lua',
    config = true,
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
  -- {
  --   'https://git.sr.ht/~sircmpwn/hare.vim',
  --   dependencies = {
  --     'https://git.sr.ht/~torresjrjr/vim-haredoc',
  --   },
  --   ft = 'hare',
  -- },
}
