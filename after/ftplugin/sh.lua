local lsp = require("lsp")
lsp.setup_server("bashls", {})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,
	},
	diagnostics_format = lsp.diagnostics_format,
})
