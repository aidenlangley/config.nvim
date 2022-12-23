local M = {}

M.enabled = true

function M.toggle()
  M.enabled = not M.enabled

  if M.enabled then
    vim.notify(
      "Enabled format on save, please reload buffer to re-attach",
      vim.log.levels.INFO,
      ---@diagnostic disable: redundant-parameter
      { title = "Auto Format" }
    )
  else
    M.disable()
    ---@diagnostic disable: redundant-parameter
    vim.notify("Disabled format on save", vim.log.levels.INFO, { title = "Auto Format" })
  end
end

function M.format()
  if vim.lsp.buf.format then
    vim.lsp.buf.format()
  else
    vim.lsp.buf.formatting_sync()
  end
end

function M.attach(bufnr)
  if M.enabled == true then
    local augroup = vim.api.nvim_create_augroup("LspAutoFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if #require("null-ls.sources").get_available(
          vim.bo.filetype,
          require("null-ls").methods.FORMATTING
        ) > 0
        then
          M.format()
        end
      end,
    })
  end
end

function M.disable()
  vim.api.nvim_del_augroup_by_name("LspAutoFormat")
end

return M
