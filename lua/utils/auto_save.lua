local M = {}

function M.auto_save(buf)
  -- If passed a buffer, use it, or get current
  buf = buf or vim.api.nvim_get_current_buf()

  -- If the buffer hasn't been modified, don't bother doing anything
  if not vim.api.nvim_buf_get_option(buf, "modified") then
    return
  end
end

M.augroup = vim.api.nvim_create_augroup("AutoSaveFocusLost", { clear = true })

function M.create_autocmd()
  local autocmd = {
    group = M.augroup,
    pattern = "*",
    callback = M.auto_save,
  }

  vim.api.nvim_create_autocmd("BufLeave", autocmd)
end

return M
