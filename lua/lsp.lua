---@class lsp
local M = {}

M.capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

---@param client LspClient
---@param bufnr integer
function M.on_attach(client, bufnr)
  require("config.keymaps").lsp(client, bufnr)
  require("lsp-inlayhints").on_attach(client, bufnr, false)
end

return M
