return {
  defaults = {
    lazy = true,
    version = false,
  },
  dev = { path = "~/Code" },
  install = {
    missing = true,
    colorscheme = { "gruvbox" },
  },
  ui = { icons = { plugin = "" } },
  checker = {
    enabled = true,
    frequency = 3600,
  },
  diff = { cmd = "diffview.nvim" },
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
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
