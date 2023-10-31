---@class DashboardItem
---@field name string
---@field action string
---@field section string

---@class Dashboard
local Dashboard = {}

---@type string
Dashboard.title = table.concat({
  [[                   |         |         ]],
  [[  __ \    _ \   _` |   _ \   __|   __| ]],
  [[  |   |   __/  (   |  (   |  |   \__ \ ]],
  [[ _|  _| \___| \__,_| \___/  \__| ____/ ]],
}, '\n')

---@type string | fun(): string
Dashboard.stats = function()
  local stats = require('lazy').stats()
  return string.format(
    '  %s/%s plugins loaded in %sms 󰄉 ',
    stats.loaded,
    stats.count,
    math.floor(stats.startuptime * 100) / 100
  )
end

---@type string | fun(): string
Dashboard.header = function()
  return string.format('%s\n\n%s', Dashboard.title, Dashboard.stats())
end

---@type string
Dashboard.footer = ''

---@type DashboardItem[]
Dashboard.items = {
  { name = 'Lazy', action = 'Lazy', section = 'Lazy' },
  { name = 'Sync', action = 'Lazy sync', section = 'Lazy' },
  { name = 'Update', action = 'Lazy update', section = 'Lazy' },
  { name = 'Log', action = 'Lazy log', section = 'Lazy' },
  { name = 'New', action = 'enew', section = 'Menu' },
  { name = 'Settings', action = 'e ~/.config/nvim/init.lua', section = 'Menu' },
  { name = 'Quit', action = 'qa!', section = 'Menu' },
  { name = 'Find', action = 'Telescope find_files', section = 'Telescope' },
  { name = 'Grep', action = 'Telescope live_grep', section = 'Telescope' },
  { name = 'Recent', action = 'Telescope oldfiles', section = 'Telescope' },
  { name = 'Projects', action = 'Telescope projects', section = 'Telescope' },
  { name = 'Help', action = 'Telescope help_tags', section = 'Telescope' },
  { name = 'Options', action = 'Telescope vim_options', section = 'Telescope' },
}

return Dashboard
