local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_Util = require("lazy.util")
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  dev = { path = "~/Code" },
  install = {
    missing = true,
    colorscheme = { "gruvbox-material" },
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
    notify = false,
  },
  performance = { cache = { enabled = true } },
})

---@module 'utils'
---@type Util
local Util = require("utils")
vim.keymap.set("n", "<Leader>sL", Util.cmd("Lazy"), { desc = "Open Lazy" })

local function nmap(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

nmap("<Leader>sc", Util.cmd("Lazy clean"), "Clean")
nmap("<Leader>sh", Util.cmd("Lazy help"), "Help")
nmap("<Leader>sp", Util.cmd("Lazy profile"), "Profile")
nmap("<Leader>ss", Util.cmd("Lazy sync"), "Sync")
nmap("<Leader>su", Util.cmd("Lazy update"), "Update")
