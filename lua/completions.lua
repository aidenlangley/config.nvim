local M = {}

M.sources = {
  { name = "buffer" },
  { name = "calc" },
  { name = "emoji" },
  { name = "path" },
}

M.lsp_sources = {
  { name = "omni" },
  { name = "nvim_lsp" },
  { name = "nvim_lsp_document_symbol" },
  { name = "nvim_lsp_signature_help" },
}

return M
