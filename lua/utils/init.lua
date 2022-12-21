local M = {}

function M.cmd(command)
  return "<CMD>" .. command .. "<CR>"
end

function M.float_term(command)
  return require("toggleterm.terminal").Terminal:new({
    cmd = command,
    hidden = true,
    direction = "float",
    border = "none",
  })
end

return M
