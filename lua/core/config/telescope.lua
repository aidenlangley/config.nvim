local ts = require("telescope")
ts.setup({
	pickers = {
		buffers = { theme = "dropdown" },
		current_buffer_fuzzy_find = { theme = "dropdown" },
		diagnostics = { theme = "ivy" },
		find_files = { theme = "dropdown" },
		grep_string = { theme = "dropdown" },
		help_tags = { theme = "dropdown" },
		live_grep = { theme = "dropdown" },
		oldfiles = { theme = "dropdown" },
	},
})

pcall(ts.load_extension, "fzf")
pcall(ts.load_extension, "notify")
pcall(ts.load_extension, "projects")

-- See `:help telescope.builtin`
local tsb = require("telescope.builtin")
vim.keymap.set("n", "<Leader>/", tsb.current_buffer_fuzzy_find, { desc = "Fuzzy search in current buffer" })
vim.keymap.set("n", "<Leader><Space>", tsb.buffers, { desc = "Find existing buffers" })
vim.keymap.set("n", "<Leader>sr", tsb.oldfiles, { desc = "[S]earch recent files" })
vim.keymap.set("n", "<Leader>sd", tsb.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<Leader>sf", tsb.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<Leader>sg", tsb.live_grep, { desc = "[S]earch via [G]rep" })
vim.keymap.set("n", "<Leader>sh", tsb.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<Leader>sw", tsb.grep_string, { desc = "[S]earch current [W]ord" })
