local config = {
	close_if_last_window = true,
	enable_diagnostics = false,
	enable_git_status = false,
	hide_root_node = true,
	use_popups_for_input = false,
	window = {
		position = "right",
		width = 32,
	},
	source_selector = {
		statusline = true,
		tab_labels = {
			filesystem = " dir",
			buffers = " buf",
			git_status = " git",
		},
		content_layout = "center",
	},
	default_component_configs = {
		indent = {
			padding = 0,
		},
	},
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = false,
		filtered_items = {
			visible = true,
			show_hidden_count = false,
		},
	},
}

require("neo-tree").setup(config)

-- Keymaps
vim.keymap.set("n", "<Leader>e", "<CMD>Neotree toggle<CR>", { desc = "[E]xplorer" })
