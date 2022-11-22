local null_ls = require("null-ls")
local lsp = require("lsp")
null_ls.setup({
	sources = { null_ls.builtins.diagnostics.commitlint },
	diagnostics_format = lsp.diagnostics_format,
})
