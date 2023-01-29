local M = {}

function M.auto_format()
  M.format({
    filter = M.prefer_null_ls,
    timeout_ms = 2000,
  })
end

function M.format(opts)
  if vim.lsp.buf.format then
    vim.lsp.buf.format(opts)
  else
    vim.lsp.buf.formatting_sync(opts, opts.timeout_ms)
  end
end

function M.prefer_null_ls(client)
  if
    #require("null-ls.sources").get_available(
      vim.bo.filetype,
      require("null-ls").methods.FORMATTING
    ) > 0
  then
    return client.name == "null-ls"
  else
    return client.supports_method("textDocument/formatting")
  end
end

M.augroup = vim.api.nvim_create_augroup("AutoFormat", { clear = true })

function M.create_autocmd()
  local autocmd = {
    group = M.augroup,
    pattern = "*",
    callback = M.auto_format,
  }

  vim.api.nvim_create_autocmd("BufWritePre", autocmd)
end

return M
