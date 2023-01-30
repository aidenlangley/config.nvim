local M = {}

function M.pad(num_spaces)
  return {
    type = "padding",
    val = num_spaces,
  }
end

function M.title(text)
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

function M.group()
  return {
    type = "group",
    val = {},
    opts = {
      position = "left",
    },
  }
end

function M.button(key, cmd, text)
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

M.layout = {
  M.pad(3),
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
  M.pad(1),
  { -- Start up time message
    type = "text",
    val = "",
    opts = {
      position = "center",
      hl = "@constructor",
    },
  },
  M.pad(3),
  M.title(" Menu"),
  M.pad(1),
  M.group(), -- Buttons
  M.pad(2),
  M.title("鈴 Lazy"),
  M.pad(1),
  M.group(), -- Lazy shortcuts
  M.pad(2),
  M.title(" Projects"),
  M.pad(1),
  M.group(), -- Recent projects
  M.pad(2),
  M.title(" Recent Files"),
  M.pad(1),
  M.group(), -- Recent files
}

function M.setup()
  local utils = require("utils")
  local menu_index = 8
  M.layout[menu_index].val[1] = M.button("e", utils.cmd("ene"), "  New")
  M.layout[menu_index].val[2] =
    M.button("s", utils.cmd("e ~/.config/nvim/init.lua"), "  Settings")
  M.layout[menu_index].val[3] = M.button("q", utils.cmd("qa"), "  Quit")

  local lazy_menu_index = 12
  M.layout[lazy_menu_index].val[1] = M.button("h", utils.cmd("Lazy home"), "  Home")
  M.layout[lazy_menu_index].val[2] = M.button("S", utils.cmd("Lazy sync"), "  Sync")
  M.layout[lazy_menu_index].val[3] = M.button("u", utils.cmd("Lazy update"), "  Update")
  M.layout[lazy_menu_index].val[4] = M.button("p", utils.cmd("Lazy profile"), "  Profile")
  M.layout[lazy_menu_index].val[5] = M.button("c", utils.cmd("Lazy clean"), "  Clean")
  M.layout[lazy_menu_index].val[6] = M.button("l", utils.cmd("Lazy log"), "  View Log")
end

return M
