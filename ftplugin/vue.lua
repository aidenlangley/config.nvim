local lsp = require("lsp")

require("lspconfig").volar.setup({
  capabilities = lsp.capabilities,
  on_attach = lsp.on_attach,
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
})
