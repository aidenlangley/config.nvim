vim.api.nvim_create_autocmd("UIEnter", {
  group = vim.api.nvim_create_augroup("ConfigKeymaps", { clear = true }),
  pattern = "*",
  callback = function()
    require("core.keymaps")
  end,
})

return {
  {
    "ahmedkhalf/project.nvim",
    cmd = { "Telescope projects" },
    opts = {
      detection_methods = { "pattern", "lsp" },
      patterns = {
        ".git",
        ".gitignore",
        ".svn",
        "^Cargo.toml",
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
