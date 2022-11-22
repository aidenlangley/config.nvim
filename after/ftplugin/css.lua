local lsp = require("lsp")
lsp.setup_server("cssls", {})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with(lsp.prettier_config),
		null_ls.builtins.diagnostics.stylelint,
	},
	diagnostics_format = lsp.diagnostics_format,
})
