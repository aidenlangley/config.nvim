local M = {
  "glepnir/lspsaga.nvim",
  event = "BufEnterPost",
  enabled = false,
}

function M.config()
  require("lspsaga").init_lsp_saga()
end

return M
