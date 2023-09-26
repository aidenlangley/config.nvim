local M = {}

M.float_term = function(command)
  return require('toggleterm.terminal').Terminal:new({
    cmd = command,
    hidden = true,
    direction = 'float',
    border = 'none',
  })
end

---Helper function to return the first path that exists or fallback to a default.
---@param paths string[]
---@param default string
---@return string
---@example
---```lua
---return {
---  command = require('utils').path_or(
---    { 'vendor/bin/php-cs-fixer' },
---    'php-cs-fixer'
---  ),
---  args = { 'fix', '$FILENAME' },
---  stdin = false,
---}
---```
M.path_or = function(paths, default)
  for _, fname in ipairs(paths) do
    local path = vim.fn.fnamemodify(fname, ':p')
    if vim.loop.fs_stat(path) then
      return path
    end
  end
  return default
end

return M
