local rt = require("rust-tools")
local opts = {
	hover_actions = {
		border = "none",
		auto_focus = true,
	},
	crate_graph = {
		backend = "gtk",
	},
	server = {
		standalone = false,
		on_attach = function(_, bufnr)
			-- Enable/disable features
			rt.inlay_hints.enable()

			require("which-key").register({ ["gr"] = { name = "Rust..." } })
			vim.keymap.set("n", "grg", rt.crate_graph.view_crate_graph, {
				desc = "View crate graph",
				silent = true,
				buffer = bufnr,
			})
			vim.keymap.set("n", "grj", rt.join_lines.join_lines, {
				desc = "Join lines",
				silent = true,
				buffer = bufnr,
			})
			vim.keymap.set("n", "grm", rt.expand_macro.expand_macro, {
				desc = "Expand macro",
				silent = true,
				buffer = bufnr,
			})
			vim.keymap.set("n", "grp", rt.parent_module.parent_module, {
				desc = "Parent module",
				silent = true,
				buffer = bufnr,
			})
			vim.keymap.set("n", "grr", rt.runnables.runnables, {
				desc = "Runnables",
				silent = true,
				buffer = bufnr,
			})
			vim.keymap.set("n", "grR", rt.ssr.ssr, {
				desc = "Structural search replace",
				silent = true,
				buffer = bufnr,
			})
			vim.keymap.set("n", "grt", rt.open_cargo_toml.open_cargo_toml, {
				desc = "Open cargo.toml",
				silent = true,
				buffer = bufnr,
			})
		end,
	},
}
rt.setup(opts)

require("lsp").setup_server("rust_analyzer", opts.server)
