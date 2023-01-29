local M = {
  "mg979/vim-visual-multi",
  keys = {
    "<C-n>", -- Selects word incrementally
    "<A-n>", -- Selects all words
    "<C-Down>",
    "<C-Left>",
    "<C-Right>",
    "<C-Up>",
  },
}

function M.config()
  vim.g.multi_cursor_start_word_key = "<C-n>"
  vim.g.multi_cursor_select_all_word_key = "<A-n>"
  vim.g.multi_cursor_start_key = "g<C-n>"
  vim.g.multi_cursor_select_all_key = "g<A-n>"
  vim.g.multi_cursor_next_key = "<C-n>"
  vim.g.multi_cursor_prev_key = "<C-p>"
  vim.g.multi_cursor_skip_key = "<C-x>"
  vim.g.multi_cursor_quit_key = "<Esc>"
end

return M
