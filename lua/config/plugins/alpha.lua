local M = {
  "goolord/alpha-nvim",
  event = "UIEnter",
  enabled = true,
}

local function pad(num_spaces)
  return {
    type = "padding",
    val = num_spaces,
  }
end

local function title(text)
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

local function group()
  return {
    type = "group",
    val = {},
    opts = {
      position = "left",
    },
  }
end

local function button(key, cmd, text)
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

local layout = {
  pad(3),
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
  pad(1),
  { -- Start up time message
    type = "text",
    val = "",
    opts = {
      position = "center",
      hl = "@constructor",
    },
  },
  pad(3),
  title(" Menu"),
  pad(1),
  group(), -- Buttons
  pad(2),
  title("鈴 Lazy"),
  pad(1),
  group(), -- Lazy shortcuts
  pad(2),
  title(" Projects"),
  pad(1),
  group(), -- Recent projects
  pad(2),
  title(" Recent Files"),
  pad(1),
  group(), -- Recent files
}

local function get_recent_projects()
  local rp = require("project_nvim").get_recent_projects()

  -- Reverse results
  for i = 1, math.floor(#rp / 2) do
    rp[i], rp[#rp - i + 1] = rp[#rp - i + 1], rp[i]
  end

  return rp
end

function M.init()
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    nested = true,
    callback = function()
      -- Checks that a file wasn't passed as an argument to nvim
      if vim.fn.argc() == 0 or #vim.v.argv == 0 then
        require("alpha").start(false)

        -- Dashboard loads after nvim has created an empty buffer, because we're
        -- waiting for LazyVimStarted to fire. Just delete the redundant buffer.
        vim.api.nvim_buf_delete(1, {})
      end
    end,
  })
end

function M.config()
  local config = {
    layout = {},
    opts = {
      margin = 12,
    },
  }

  local stats = require("lazy").stats()
  layout[4].val = "  "
    .. stats.loaded
    .. "/"
    .. stats.count
    .. " plugins, "
    .. (math.floor(stats.startuptime * 100 + 0.5) / 100)
    .. "ms  "

  local utils = require("utils")
  local menu_index = 8
  layout[menu_index].val[1] = button("e", utils.cmd("ene"), "  New")
  layout[menu_index].val[2] = button("s", utils.cmd("e ~/.config/nvim/init.lua"), "  Settings")
  layout[menu_index].val[3] = button("q", utils.cmd("qa"), "  Quit")

  local lazy_menu_index = 12
  layout[lazy_menu_index].val[1] = button("h", utils.cmd("Lazy home"), "  Home")
  layout[lazy_menu_index].val[2] = button("S", utils.cmd("Lazy sync"), "  Sync")
  layout[lazy_menu_index].val[3] = button("u", utils.cmd("Lazy update"), "  Update")
  layout[lazy_menu_index].val[4] = button("p", utils.cmd("Lazy profile"), "  Profile")
  layout[lazy_menu_index].val[5] = button("c", utils.cmd("Lazy clean"), "  Clean")
  layout[lazy_menu_index].val[6] = button("l", utils.cmd("Lazy log"), "  View Log")

  for _, project_path in ipairs(get_recent_projects()) do
    local index = #layout[16].val + 1

    -- Only print 9 most recent projects
    if index >= 11 then
      break
    end

    local cmd = utils.cmd("e " .. project_path .. "<Bar>Telescope find_files")
    local project_name = vim.fn.fnamemodify(project_path, ":t")
    local short_project_path = vim.fn.fnamemodify(project_path, ":~")
    local text = " " .. project_name .. " (" .. short_project_path .. ")"
    layout[16].val[index] = button(tostring(index - 1), cmd, text)
  end

  for _, filename in ipairs(vim.v.oldfiles) do
    local index = #layout[20].val + 1
    local cmd = utils.cmd("e " .. filename)
    if vim.fn.filereadable(filename) == 1 then
      local short_filename = vim.fn.fnamemodify(filename, ":~")
      layout[20].val[index] = button(tostring((index + 10) - 1), cmd, " " .. short_filename)
    end
  end

  config.layout = layout
  require("alpha").setup(config)
end

return M
