return {
  {
    'williamboman/mason.nvim',
    lazy = true,
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog',
    },
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    lazy = true,
    opts = {
      ensure_installed = {
        'bashls',
        'denols',
        'dockerls',
        'jsonls',
        'lua_ls',
        'pyright',
        'rust_analyzer',
        'taplo',
        'yamlls',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
      'williamboman/mason.nvim',
      'b0o/SchemaStore.nvim',
    },
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      inlay_hints = { enabled = true },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
        },
      },
    },
    config = function(_, opts)
      for name, icon in pairs(require('icons').diagnostics) do
        name = 'DiagnosticSign' .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
      end
      vim.diagnostic.config(opts.diagnostics)

      local handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({
            on_attach = require('lsp._on_attach'),
            capabilities = require('lsp._capabilities'),
          })
        end,
      }

      require('mason-lspconfig').setup_handlers(handlers)
    end,
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
}