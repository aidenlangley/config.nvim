---@alias keymap.Mode string | string[] The modes this keymap applies to
---@alias keymap.Keys string | string[] The keys that trigger rhs
---@alias keymap.Command string | function The vim cmd or lua function to run
---@alias keymap.Options table<string, any> `table` of options
---@alias keymap.KeymapFn fun(mode: keymap.Mode, keys: keymap.Keys, cmd: keymap.Command, opts: keymap.Options?)

---@class KeymapOptions
---@field expr boolean
---@field noremap boolean
---@field nowait boolean
---@field script boolean
---@field silent boolean
---@field unique boolean

---@class Keymap
---@field keymap keymap.KeymapFn
---@field leader keymap.KeymapFn
local Keymap = {}

---@type KeymapOptions
Keymap.options = {
  expr = false,
  noremap = true,
  nowait = false,
  script = false,
  silent = true,
  unique = false,
}

---@param opts keymap.Options
---@return keymap.Options opts Extended options
Keymap.extend_opts = function(opts)
  return vim.tbl_deep_extend('force', Keymap.options, opts)
end

Keymap.keymap = function(mode, keys, cmd, opts)
  local o = Keymap.extend_opts(opts or {})
  if type(keys) == 'table' then
    for _, key in ipairs(keys) do
      vim.keymap.set(mode, key, cmd, o)
    end
  else
    vim.keymap.set(mode, keys, cmd, o)
  end
end

Keymap.leader = function(mode, keys, cmd, opts)
  if type(keys) == 'table' then
    for index, value in ipairs(keys) do
      keys[index] = '<Leader>' .. value
    end
  else
    keys = '<Leader>' .. keys
  end
  Keymap.keymap(mode, keys, cmd, opts)
end

return Keymap
