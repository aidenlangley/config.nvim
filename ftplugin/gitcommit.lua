local null_ls = require("null-ls")
null_ls.setup({
	sources = { null_ls.builtins.diagnostics.commitlint },
	diagnostics_format = require("core.config.null_ls").diagnostics_format,
})
