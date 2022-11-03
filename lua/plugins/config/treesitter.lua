require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"lua",
		"yaml",
		"css",
		"go",
		"html",
		"javascript",
		"python",
		"rust",
		"svelte",
		"toml",
		"typescript",
		"vue",
	},
	auto_install = true,
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	highlight = {
		enable = true,
		disable = {
			"txt",
			"vue",
		},
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = false,
	},
})

require("symbols-outline").setup({})
