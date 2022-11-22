vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	view = {
		adaptive_size = true,
		side = "right",
		mappings = {
			list = {
				{ key = "d", action = "trash" },
				{ key = "D", action = "remove" },
			},
		},
	},
	renderer = {
		icons = {
			git_placement = "after",
		},
	},
	trash = {
		cmd = "gio trash",
	},
	git = {
		ignore = false,
	},
})
