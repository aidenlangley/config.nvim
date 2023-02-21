return {
  "nvim-lua/plenary.nvim",
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    event = "BufReadPost",
    cmd = "Telescope projects",
    keys = { "tp" },
    opts = {
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
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },
}
