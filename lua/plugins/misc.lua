return {
  "nvim-lua/plenary.nvim",
  {
    "ahmedkhalf/project.nvim",
    init = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
        patterns = {
          ".git",
          ".gitignore",
          "package.json",
        },
        exclude_dirs = {
          "~/.cargo/*",
          "~/.local/share/*",
          "~/.rustup/*",
        },
        silent_chdir = true,
        show_hidden = true,
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    cmd = { "ZenMode" },
    keys = {
      {
        "<S-z>",
        require("utils").cmd("ZenMode"),
        desc = "ZenMode",
      },
    },
    opts = { plugins = { gitsigns = true } },
  },
  { "fladson/vim-kitty", ft = "kitty" },
}
