require('lspconfig').yamlls.setup({
  on_attach = require('lsp._on_attach'),
  capabilities = require('lsp._capabilities'),
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})
