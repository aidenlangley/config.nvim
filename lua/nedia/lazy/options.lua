---@type table
return {
  change_detection = { notify = true },
  checker = { enabled = true },
  concurrency = 4,
  defaults = { lazy = true },
  dev = { path = '~/Code' },
  install = { colorscheme = { 'gruvbox' } },
  performance = {
    disabled_plugins = {
      'gzip',
      'matchit',
      'matchparen',
      'netrwPlugin',
      'tarPlugin',
      'tohtml',
      'tutor',
      'zipPlugin',
    },
  },
  profiling = {
    loader = true,
    require = true,
  },
}
