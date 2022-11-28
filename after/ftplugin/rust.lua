local rt = require("rust-tools")
rt.setup({
	hover_actions = {
		border = "single",
		auto_focus = true,
	},
	server = {
		on_attach = function(_, bufnr)
			-- Enable/disable features
			rt.inlay_hints.enable()

			vim.keymap.set("n", "<C-a>", rt.hover_actions.hover_actions, {
				desc = "[Rust] Hover actions",
				buffer = bufnr,
				noremap = true,
			})
			vim.keymap.set("n", "<C-Space>", rt.code_action_group.code_action_group, {
				desc = "[Rust] Code actions",
				buffer = bufnr,
				noremap = true,
			})

			require("which-key").register("gr", "Rust...")
			vim.keymap.set("n", "grr", rt.runnables.runnables, {
				desc = "Runnables",
				buffer = bufnr,
				noremap = true,
			})
			vim.keymap.set("n", "grm", rt.expand_macro.expand_macro, {
				desc = "Expand macro",
				buffer = bufnr,
				noremap = true,
			})
			vim.keymap.set("n", "grt", rt.open_cargo_toml.open_cargo_toml, {
				desc = "Open cargo.toml",
				buffer = bufnr,
				noremap = true,
			})
			vim.keymap.set("n", "grp", rt.parent_module.parent_module, {
				desc = "Parent module",
				buffer = bufnr,
				noremap = true,
			})
		end,
	},
})

require("lsp").setup_server("rust_analyzer", {})
