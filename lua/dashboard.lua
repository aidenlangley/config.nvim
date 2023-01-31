---@module 'dashboard'
---@author Aiden Langley
---@license MIT

---@class DashboardItem
---@field type string
---@field val any
---@field on_press? fun()
---@field opts { position?: string, shrink_margin?: boolean, keymap?: string[] | table<string, any>[] }
---@field shortcut? string
---@field align_shortcut? string
---@field hl_shortcut? string

---@class Dashboard
local Dashboard = {}

---@param num_spaces integer
---@return { type: string, val: integer }
function Dashboard.pad(num_spaces)
  return {
    type = "padding",
    val = num_spaces,
  }
end

---@param text string
---@return DashboardItem
function Dashboard.title(text)
  if text then
    text = text .. (" "):rep(16 - #text)
  end

  return {
    type = "text",
    val = text or "",
    opts = {
      position = "left",
      hl = "@text.note",
    },
  }
end

---@return DashboardItem
function Dashboard.group()
  return {
    type = "group",
    val = {},
    opts = {
      position = "left",
    },
  }
end

---@param key string
---@param cmd string
---@param text string
---@return DashboardItem
function Dashboard.button(key, cmd, text)
  return {
    type = "button",
    val = text,
    on_press = function()
      local _key = vim.api.nvim_replace_termcodes(cmd .. "<Ignore>", true, false, true)
      vim.api.nvim_feedkeys(_key, "t", false)
    end,
    opts = {
      position = "left",
      keymap = {
        "n",
        key:gsub("%s", ""):gsub("SPC", "<Leader>"),
        cmd,
        {
          desc = text,
          noremap = false,
          silent = true,
          nowait = true,
        },
      },
      shortcut = "[" .. key .. "] ",
      align_shortcut = "left",
      hl_shortcut = "@text.strong",
    },
  }
end

Dashboard.layout = {
  Dashboard.pad(3),
  {
    type = "text",
    val = {
      [[                   |         |         ]],
      [[  __ \    _ \   _` |   _ \   __|   __| ]],
      [[  |   |   __/  (   |  (   |  |   \__ \ ]],
      [[ _|  _| \___| \__,_| \___/  \__| ____/ ]],
    },
    opts = {
      position = "center",
      hl = "@character",
      shrink_margin = false,
    },
  },
  Dashboard.pad(1),
  { -- Start up time message
    type = "text",
    val = "",
    opts = {
      position = "center",
      hl = "@constructor",
    },
  },
  Dashboard.pad(3),
  Dashboard.title(" Menu"),
  Dashboard.pad(1),
  Dashboard.group(), -- Buttons
  Dashboard.pad(2),
  Dashboard.title("鈴 Lazy"),
  Dashboard.pad(1),
  Dashboard.group(), -- Lazy shortcuts
  Dashboard.pad(2),
  Dashboard.title(" Projects"),
  Dashboard.pad(1),
  Dashboard.group(), -- Recent projects
  Dashboard.pad(2),
  Dashboard.title(" Recent Files"),
  Dashboard.pad(1),
  Dashboard.group(), -- Recent files
}

function Dashboard.setup()
  ---@module 'utils'
  ---@type Util
  local Util = require("utils")

  local menu = Dashboard.layout[8]
  ---@type DashboardItem
  menu.val[1] = Dashboard.button("e", Util.cmd("ene"), "  New")
  ---@type DashboardItem
  menu.val[2] = Dashboard.button("s", Util.cmd("e ~/.config/nvim/init.lua"), "  Settings")
  ---@type DashboardItem
  menu.val[3] = Dashboard.button("q", Util.cmd("qa"), "  Quit")

  local lazy_menu = Dashboard.layout[12]
  ---@type DashboardItem
  lazy_menu.val[1] = Dashboard.button("h", Util.cmd("Lazy home"), "  Home")
  ---@type DashboardItem
  lazy_menu.val[2] = Dashboard.button("S", Util.cmd("Lazy sync"), "  Sync")
  ---@type DashboardItem
  lazy_menu.val[3] = Dashboard.button("u", Util.cmd("Lazy update"), "  Update")
  ---@type DashboardItem
  lazy_menu.val[4] = Dashboard.button("p", Util.cmd("Lazy profile"), "  Profile")
  ---@type DashboardItem
  lazy_menu.val[5] = Dashboard.button("c", Util.cmd("Lazy clean"), "  Clean")
  ---@type DashboardItem
  lazy_menu.val[6] = Dashboard.button("l", Util.cmd("Lazy log"), "  View Log")
end

return Dashboard
