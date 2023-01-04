local M = {
  "ahmedkhalf/project.nvim",
}

local patterns = {
  ".git",
  ".gitignore",
  "package.json",
}

local exclude_dirs = {
  "~/.cargo/*",
  "~/.local/share/*",
  "~/.rustup/*",
}

function M.init()
  require("project_nvim").setup({
    detection_methods = { "pattern" },
    patterns = patterns,
    exclude_dirs = exclude_dirs,
    silent_chdir = true,
    show_hidden = true,
  })
end

return M
