---@class Formatter
local Formatter = {}

---@param formatter conform.FormatterConfig Existing formatter
---@param args string[] New args
---@return conform.FormatterConfig formatter New formatter
Formatter.extend = function(formatter, args)
  return vim.tbl_extend(
    'force',
    formatter,
    { require('conform.util').extend_args(formatter.args or {}, args) }
  )
end

-- Get formatters for this buffer
---@param bufnr number? Buffer identifier
---@return string formatters Active formatters as space separated string
Formatter.active_formatters = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  return table.concat(require('conform').list_formatters_for_buffer(bufnr), ' ')
end

return Formatter
