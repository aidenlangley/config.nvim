local golines_config = {
	extra_args = {
		"-m",
		"80",
		"-t",
		"2",
		"--base-formatter",
		"gofumpt",
	},
}

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.golines.with(golines_config),
	},
	diagnostics_format = require("core.config.null_ls").diagnostics_format,
})
