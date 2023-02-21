local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_Util = require("lazy.util")
require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
    version = false,
  },
  dev = { path = "~/Code" },
  install = {
    missing = true,
    colorscheme = { "gruvbox" },
  },
  ui = {
    icons = { plugin = "" },
    custom_keys = {
      ["gg"] = function(plugin)
        lazy_Util.float_term({ "lazygit", "log" }, { cwd = plugin.dir })
      end,
      ["gt"] = function(plugin)
        lazy_Util.float_term(nil, { cwd = plugin.dir })
      end,
      ["go"] = function(plugin)
        lazy_Util.open(plugin.url)
      end,
    },
  },
  checker = {
    enabled = true,
    frequency = 3600,
  },
  diff = { cmd = "diffview.nvim" },
  change_detection = {
    enabled = true,
    notify = true,
  },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

---@module 'utils'
---@type utils
local utils = require("utils")

local function nmap(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

vim.keymap.set("n", "<Leader>sL", utils.cmd("Lazy"), { desc = "Open Lazy" })
nmap("<Leader>sc", utils.cmd("Lazy clean"), "Clean")
nmap("<Leader>sh", utils.cmd("Lazy help"), "Help")
nmap("<Leader>sp", utils.cmd("Lazy profile"), "Profile")
nmap("<Leader>ss", utils.cmd("Lazy sync"), "Sync")
nmap("<Leader>su", utils.cmd("Lazy update"), "Update")
