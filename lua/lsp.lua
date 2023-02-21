---@class lsp
local M = {}

---@type table
local capabilities = vim.lsp.protocol.make_client_capabilities()

---@type function
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

---@param client LspClient
---@param bufnr integer
function M.on_attach(client, bufnr)
  require("config.keymaps").lsp(client, bufnr)

  local cmp = require("cmp")
  local completions = require("completions")
  cmp.setup.buffer({
    sources = cmp.config.sources(completions.lsp_sources, completions.sources),
  })
end

return M
