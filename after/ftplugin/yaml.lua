local lsp = require("lsp")
lsp.setup_server("yamlls", {})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "yaml", "yml" },
			args = { "--no-bracket-spacing" },
		}),
		null_ls.builtins.diagnostics.yamllint,
	},
	diagnostics_format = lsp.diagnostics_format,
})
