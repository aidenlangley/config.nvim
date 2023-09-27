require('lspconfig').jsonls.setup({
  on_attach = require('lsp._on_attach'),
  capabilities = require('lsp._capabilities'),
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})
