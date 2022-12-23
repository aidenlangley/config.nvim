local M = {
  "ahmedkhalf/project.nvim",
}

function M.init()
  local patterns = {
    ".git",
    ".gitignore",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
    "package.json",
  }

  require("project_nvim").setup({
    patterns = patterns,
  })
end

return M
