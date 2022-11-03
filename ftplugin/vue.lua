local lsp = require("plugins.config.lsp")
lsp.setup_server("volar", {
	filetypes = {
		"typescript",
		"javascript",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"json",
	},
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with(lsp.prettier_config),
		null_ls.builtins.diagnostics.eslint.with(lsp.eslint_config),
	},
	diagnostics_format = lsp.diagnostics_format,
})
