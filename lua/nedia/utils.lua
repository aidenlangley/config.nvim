---@class Utils
local Utils = {}

local Keymap = require('nedia.core.keymap')
Utils.keymap = Keymap.keymap
Utils.leader = Keymap.leader

-- Quit if not modified, else request confirmation
---@param bufnr number? Buffer identifier, if nil then `nvim_get_current_buf`
Utils.smart_quit = function(bufnr)
  local modified = vim.api.nvim_buf_get_option(
    bufnr or vim.api.nvim_get_current_buf(),
    'modified'
  )

  if modified then
    local p, c =
      'You have unsaved changes. Quit anyway? (y/N) ', function(input)
        if input == 'y' then
          vim.cmd('q!')
        end
      end
    vim.ui.input({ prompt = p }, c)
  else
    vim.cmd('q!')
  end
end

---@param cmd string The command to run in a floating terminal
---@return Terminal
Utils.float_term = function(cmd)
  return require('toggleterm.terminal').Terminal:new({
    cmd = cmd,
    hidden = true,
    direction = 'float',
    border = 'none',
  })
end

-- Get linters for this buffer
---@param bufnr number? Buffer identifier
---@return string linters Active formatters as space separated string
Utils.active_linters = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return table.concat(require('lint').linters_by_ft[vim.bo.filetype] or {}, ' ')
end

---@param str string String to surround with ': .. <CR>'
---@return string cmd
Utils.cmd = function(str)
  return ':' .. str .. '<CR>'
end

return Utils
