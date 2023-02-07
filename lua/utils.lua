---@class utils
local M = {}

---@param command string
---@return string
function M.cmd(command)
  return "<CMD>" .. command .. "<CR>"
end

---@param command string
---@return Terminal
function M.float_term(command)
  return require("toggleterm.terminal").Terminal:new({
    cmd = command,
    hidden = true,
    direction = "float",
    border = "none",
  })
end

---@param bufnr integer
function M.smart_quit(bufnr)
  local prompt = "You have unsaved changes. Quit anyway? (y/N) "
  local callback = function(input)
    if input == "y" then
      vim.cmd("q!")
    end
  end

  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")

  if modified then
    vim.ui.input({ prompt = prompt }, callback)
  else
    vim.cmd("q!")
  end
end

---@param source Source
function M.register_null_ls_source(source)
  local sources = require("null-ls.sources")
  if not sources.is_registered(source.name) then
    sources.register(source)
  end
end

---@param sources Source[]
function M.register_null_ls_sources(sources)
  for _, source in ipairs(sources) do
    M.register_null_ls_source(source)
  end
end

return M
