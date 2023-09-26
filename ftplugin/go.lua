require('lspconfig').gopls.setup({
  capabilities = require('lsp._capabilities'),
  on_attach = require('lsp._on_attach'),
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
})
