local black_config = {
	args = {
		"--line-length",
		"79",
	},
}

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black.with(black_config),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.flake8,
	},
	diagnostics_format = require("core.config.null_ls").diagnostics_format,
})
