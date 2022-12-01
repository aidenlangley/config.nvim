require("project_nvim").setup({
	show_hidden = true,
	silent_chdir = true,
	patterns = {
		".git",
		".gitignore",
		".luacheckrc",
		"cargo.toml",
		"Makefile",
		"package.json",
	},
})
