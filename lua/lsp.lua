---@module 'lsp'
---@author Aiden Langley
---@license MIT

---@class LspClient
---@field id integer
---@field name string
---@field rpc table
---@field handlers table
---@field requests table
---@field config table
---@field server_capabilities table

---@class LspHelper
local LspHelper = {}

---@class ClientCapabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

---@type function
LspHelper.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

---@param client LspClient
---@param bufnr integer
function LspHelper.on_attach(client, bufnr)
  require("config.keymaps").lsp(client, bufnr)
end

return LspHelper
