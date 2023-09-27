require('lspconfig').gopls.setup({
  capabilities = require('lsp._capabilities'),
  on_attach = require('lsp._on_attach'),
  settings = {
    formatting = {
      gofumpt = true,
    },
  },
})

require('conform.formatters.golines').args = { '-m', '80' }
