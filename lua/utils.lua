local M = {}

M.float_term = function(command)
  return require('toggleterm.terminal').Terminal:new({
    cmd = command,
    hidden = true,
    direction = 'float',
    border = 'none',
  })
end

return M