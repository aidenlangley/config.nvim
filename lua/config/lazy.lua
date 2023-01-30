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

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  dev = { path = "~/Code" },
  install = { colorscheme = { "gruvbox-material" } },
  ui = {
    wrap = false,
    icons = { plugin = "" },
  },
  checker = {
    enabled = true,
    frequency = 3600,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

local utils = require("utils")
vim.keymap.set("n", "<Leader>sL", utils.cmd("Lazy"), { desc = "Lazy" })

local function nmap(keys, func, desc)
  desc = "Lazy: " .. (desc or "?")
  vim.keymap.set("n", keys, func, { desc = desc })
end

nmap("<Leader>sc", utils.cmd("Lazy clean"), "Clean")
nmap("<Leader>sh", utils.cmd("Lazy help"), "Help")
nmap("<Leader>sp", utils.cmd("Lazy profile"), "Profile")
nmap("<Leader>ss", utils.cmd("Lazy sync"), "Sync")
nmap("<Leader>su", utils.cmd("Lazy update"), "Update")
