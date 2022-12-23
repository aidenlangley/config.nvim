local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("config.plugins", {
  defaults = {
    lazy = true,
  },
  concurrency = 4,
  install = {
    colorscheme = {
      "gruvbox-material",
      "habamax",
    },
  },
  checker = {
    enabled = true,
    concurrency = 1,
    frequency = 3600,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
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
  if desc then
    desc = "Lazy: " .. desc
  end

  vim.keymap.set("n", keys, func, { desc = desc })
end

nmap("<Leader>ss", utils.cmd("Lazy sync"), "Sync")
nmap("<Leader>sp", utils.cmd("Lazy profile"), "Profile")
nmap("<Leader>sh", utils.cmd("Lazy help"), "Help")
