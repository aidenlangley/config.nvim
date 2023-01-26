local M = {}

function M.format(opts)
  if vim.lsp.buf.format then
    vim.lsp.buf.format(opts)
  else
    vim.lsp.buf.formatting_sync(opts)
  end
end

function M.prefer_null_ls()
  M.format({
    filter = function(client)
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
    end,
    timeout_ms = 2000,
  })
end

M.augroup = vim.api.nvim_create_augroup("AutoFormat", { clear = true })

function M.create_autocmd()
  local autocmd = {
    group = M.augroup,
    pattern = "*",
    callback = M.prefer_null_ls,
  }

  vim.api.nvim_create_autocmd("BufWritePre", autocmd)
end

return M
