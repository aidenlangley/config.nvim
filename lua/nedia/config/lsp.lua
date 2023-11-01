local Lsp = require('nedia.lsp')

local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  Lsp.capabilities = vim.tbl_deep_extend(
    'force',
    Lsp.capabilities,
    cmp_lsp.default_capabilities()
  )
end

-- Set up default handler & other configured server handlers
for k, v in pairs(Lsp.servers) do
  ---@type table<string, fun(server: string, config: table)>
  Lsp.handlers[k] = Lsp.setup_server(k, v or {})
end
require('mason-lspconfig').setup_handlers(Lsp.handlers)

-- Define icons
for name, icon in pairs(Lsp.icons) do
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
end

-- Configure diagnostics
vim.diagnostic.config(Lsp.diagnostic_config)

local utils = require('nedia.utils')
local leader, cmd = utils.leader, utils.cmd
leader('n', 'lsp', cmd('LspInfo'), { desc = 'LPS info' })
leader('n', 'lst', cmd('LspStart'), { desc = 'Start LSP server' })
leader('n', 'lsx', cmd('LspStop'), { desc = 'Stop LSP server' })
leader('n', 'lsr', cmd('LspRestart'), { desc = 'Restart LSP server' })
leader('n', 'lsl', cmd('LspLog'), { desc = 'LPS log' })
