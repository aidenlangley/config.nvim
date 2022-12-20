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

vim.keymap.set("n", "<Leader>sp", require("telescope").extensions.projects.projects, { desc = "[S]earch [P]rojects" })
