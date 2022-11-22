local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.fish_indent,
		null_ls.builtins.diagnostics.fish,
	},
	diagnostics_format = require("lsp").diagnostics_format,
})
