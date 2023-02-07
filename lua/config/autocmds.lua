-- .ron (for `wired-notify`) is Rust
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("RonIsRust", {}),
  pattern = "*.ron",
  command = "setfiletype rust",
})

-- Resize windows when we close our explorer
-- vim.api.nvim_create_autocmd("BufLeave", {
--   group = vim.api.nvim_create_augroup("ExplorerLostFocus", { clear = true }),
--   pattern = "neo-tree *",
--   command = "wincmd =",
-- })

-- Highlight on yank
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
--   pattern = "*",
--   command = "lua vim.highlight.on_yank()",
-- })
