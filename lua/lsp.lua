local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

function M.on_attach(client, bufnr)
  require("config.keymaps").lsp(client, bufnr)
end

return M
