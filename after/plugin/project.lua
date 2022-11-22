require("project_nvim").setup({
	show_hidden = true,
	silent_chdir = false,
	patterns = {
		".git",
		".gitignore",
		".luacheckrc",
		"cargo.toml",
		"Makefile",
		"package.json",
	},
})
