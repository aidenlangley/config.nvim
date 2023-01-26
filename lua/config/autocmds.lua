require("utils.lsp.auto_format").create_autocmd()

-- Write buffer when focus lost
-- require("utils.auto_save").create_autocmd()

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- .ron (for `wired-notify`) is Rust
vim.api.nvim_create_autocmd("BufRead", {
  command = "setfiletype rust",
  group = vim.api.nvim_create_augroup("RonIsRust", {}),
  pattern = "*.ron",
})
