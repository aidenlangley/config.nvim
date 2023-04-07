local M = {}

M.sources = {
  { name = "nvim_lsp" },
  { name = "nvim_lsp_signature_help" },
  { name = "luasnip" },
  { name = "buffer" },
  { name = "calc" },
  { name = "path", trigger_characters = { "~", "/" } },
  { name = "nerdfont", trigger_characters = { ":" } },
  { name = "emoji", trigger_characters = { ":" } },
  { name = "copilot" },
}

return M
