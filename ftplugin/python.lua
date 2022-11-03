local lsp = require("plugins.config.lsp")
lsp.setup_server("pyright", {})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black.with({ args = { "--line-length", "79" } }),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.flake8,
	},
	diagnostics_format = lsp.diagnostics_format,
})
