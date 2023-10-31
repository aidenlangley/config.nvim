---@class Statusline
local StatusLine = {}

local icons = require('nedia.icons')
local colours = require('nedia.colours')

StatusLine.mode = {
  'mode',
  fmt = function(str)
    return str:sub(1, 1)
  end,
}

StatusLine.diagnostics = {
  'diagnostics',
  sources = {
    'nvim_lsp',
    'nvim_diagnostic',
  },
  sections = {
    'error',
    'warn',
    'info',
    'hint',
  },
  symbols = {
    error = icons.DiagnosticError,
    warn = icons.DiagnosticWarn,
    info = icons.DiagnosticInfo,
    hint = icons.DiagnosticHint,
  },
  diagnostics_color = {
    color_error = { fg = colours.neutral_red },
    color_warn = { fg = colours.neutral_yellow },
    color_info = { fg = colours.neutral_aqua },
    color_hint = { fg = colours.neutral_grey },
  },
}

StatusLine.clients = {
  'clients',
  fmt = function()
    local bufnr = vim.api.nvim_get_current_buf()
    return string.format(
      ' %s %s %s',
      require('nedia.lsp').active_clients(bufnr),
      require('nedia.core.formatter').active_formatters(bufnr),
      require('nedia.utils').active_linters(bufnr)
    )
  end,
}

StatusLine.diff = {
  'diff',
  colored = true,
  diff_color = {
    color_added = { fg = colours.neutral_green },
    color_modified = { fg = colours.neutral_yellow },
    color_removed = { fg = colours.neutral_red },
  },
  symbols = {
    added = icons.GitAdd,
    modified = icons.GitChange,
    removed = icons.GitDelete,
  },
}

return StatusLine
