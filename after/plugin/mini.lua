require("mini.align").setup({})
require("mini.bufremove").setup({})
require("mini.comment").setup({})
require("mini.cursorword").setup({})
require("mini.pairs").setup({})
require("mini.tabline").setup({})

-- Due to conflicts with leap, we're changing the prefix 's' to generally be
-- a suffix
require("mini.surround").setup({
	mappings = {
		add = "ys",
		delete = "ds",
		find = "",
		find_left = "",
		highlight = "",
		replace = "cs",
		update_n_lines = "",
	},
})
