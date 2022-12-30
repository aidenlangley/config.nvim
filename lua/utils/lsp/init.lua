local M = {}

function M.get_clients(bufnr)
  local clients = {}

  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
    -- When handling null-ls clients, we have to further inspect the sources
    if client.name == "null-ls" then
      for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
        clients[#clients + 1] = string.sub(source.name, 1, 8)
      end
    else
      clients[#clients + 1] = string.sub(client.name, 1, 8)
    end
  end

  return table.concat(clients, ", "), " "
end

return M
