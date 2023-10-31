---@class Lsp
---@field on_attach fun(client: table?, bufnr: number?)
local Lsp = {}

Lsp.on_attach = function(_, bufnr)
  local Utils = require('nedia.utils')
  local keymap = Utils.keymap

  keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
  keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto definition' })
  keymap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration' })
  keymap('n', 'gi', vim.lsp.buf.implementation, { desc = 'Goto impl' })
  keymap('n', 'go', vim.lsp.buf.type_definition, { desc = 'Goto type def' })
  keymap('n', 'gr', vim.lsp.buf.references, { desc = 'Goto references' })
  keymap('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Signature help' })
  keymap('n', '<C-.>', vim.lsp.buf.code_action, { desc = 'Code actions' })

  local fn = vim.lsp.buf.rename
  local opts = { expr = false, desc = 'Rename', buffer = bufnr }

  ---@diagnostic disable-next-line: no-unknown
  local ok, _ = pcall(require, 'inc_rename')
  if ok then
    fn = function()
      return ':IncRename ' .. vim.fn.expand('<cword>')
    end
    opts.expr = true
  end

  keymap('n', '<F2>', fn, opts)
end

---@type table
Lsp.capabilities = vim.lsp.protocol.make_client_capabilities()

---@type table<string, table>
Lsp.servers = {
  gopls = require('nedia.lsp.servers.go'),
  jsonls = require('nedia.lsp.servers.json'),
  lua_ls = require('nedia.lsp.servers.lua'),
  rust_analyzer = require('nedia.lsp.servers.rust'),
  yamlls = require('nedia.lsp.servers.yaml'),
}

---@type table<string, fun(server: string)>
Lsp.handlers = {
  function(server)
    Lsp.setup_server(server, {})
  end,
}

---@type table<string, string>
Lsp.icons = {
  DiagnosticSignError = require('nedia.icons').DiagnosticError,
  DiagnosticSignWarn = require('nedia.icons').DiagnosticWarn,
  DiagnosticSignHint = require('nedia.icons').DiagnosticHint,
  DiagnosticSignInfo = require('nedia.icons').DiagnosticInfo,
}

---@type table
Lsp.diagnostic_config = {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    spacing = 4,
    source = 'if_many',
  },
}

---@param server string Name of the server
---@param config table Table of settings
Lsp.setup_server = function(server, config)
  config['on_attach'] = Lsp.on_attach
  config['capabilities'] = Lsp.capabilities
  require('lspconfig')[server].setup(config)
end

-- Get LSP clients for this buffer
---@param bufnr number? Buffer identifier
---@return string clients Active clients as space separated string
Lsp.active_clients = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients, names = vim.lsp.get_active_clients({ bufnr = bufnr }), {}

  ---@param c { name: string }
  for _, c in ipairs(clients) do
    ---@type string
    names[#names + 1] = c.name
  end

  return table.concat(names, ' ')
end

return Lsp
