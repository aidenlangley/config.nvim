-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

-- .ron (for `wired-notify`) is Rust
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("RonIsRust", {}),
  pattern = "*.ron",
  command = "setfiletype rust",
})
