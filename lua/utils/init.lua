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

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")

  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/N) ",
    }, function(input)
      if input == "y" then
        vim.cmd("q!")
      end
    end)
  else
    vim.cmd("q!")
  end
end

return M
