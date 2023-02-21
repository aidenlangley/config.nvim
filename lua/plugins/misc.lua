return {
  {
    "ahmedkhalf/project.nvim",
    event = { "VeryLazy" },
    opts = {
      detection_methods = { "pattern", "lsp" },
      patterns = {
        "=src",
        ".git",
        ".gitignore",
        ".svn",
        "Makefile",
        "package.json",
      },
      exclude_dirs = {
        "~/.cargo/*",
        "~/.local/share/*",
        "~/.rustup/*",
      },
      silent_chdir = true,
      show_hidden = false,
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },
}
