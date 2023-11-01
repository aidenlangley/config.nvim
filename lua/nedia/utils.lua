---@class Utils
local Utils = {}

local Keymap = require('nedia.core.keymap')
Utils.keymap = Keymap.keymap
Utils.leader = Keymap.leader

-- Quit if not modified, else request confirmation
---@param bufnr number? Buffer identifier, if nil then `nvim_get_current_buf`
---@param quit_fn function? Function to quit (or perhaps delete buffer)
Utils.smart_quit = function()
  if vim.bo.modified then
    local choice = vim.fn.confirm(
      ('Save changes to %q?'):format(vim.fn.bufname()),
      '&Yes\n&No\n&Cancel'
    )
    if choice == 1 then -- Yes
      vim.cmd.write()
      vim.cmd('q')
    elseif choice == 2 then -- No
      vim.cmd('q!')
    end
  else
    vim.cmd('q')
  end
end

Utils.safe_delete = function()
  ---@type function
  local bd

  local ok, bufremove = pcall(require, 'mini.bufremove')
  if ok then
    bd = bufremove.delete
  else
    bd = function(_, force)
      if force then
        vim.cmd('bd!')
      else
        vim.cmd('bd')
      end
    end
  end

  if vim.bo.modified then
    local choice = vim.fn.confirm(
      ('Save changes to %q?'):format(vim.fn.bufname()),
      '&Yes\n&No\n&Cancel'
    )
    if choice == 1 then -- Yes
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then -- No
      bd(0, true)
    end
  else
    bd(0)
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
Utils.active_linters = function()
  return table.concat(require('lint').linters_by_ft[vim.bo.filetype] or {}, ' ')
end

---@param str string String to surround with ': .. <CR>'
---@return string cmd
Utils.cmd = function(str)
  return ':' .. str .. '<CR>'
end

return Utils
