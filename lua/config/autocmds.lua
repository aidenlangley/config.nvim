-- Auto format
-- Formats with null-ls over LSP
local lsp_group = vim.api.nvim_create_augroup("Lsp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({
      timeout_ms = 1000,
      filter = function(client)
        local n = require("null-ls")
        local s = require("null-ls.sources")
        local available = s.get_available(vim.bo.filetype, n.methods.FORMATTING)

        if #available > 0 then
          return client.name == "null-ls"
        elseif client.supports_method("textDocument/formatting") then
          return true
        else
          return false
        end
      end,
    })
  end,
  group = lsp_group,
  pattern = "*",
})

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
  clear = true,
})
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
