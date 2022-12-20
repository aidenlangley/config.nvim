local null_ls = require("null-ls")
local config = require("core.config.null_ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with(config.configs.prettier),
		null_ls.builtins.diagnostics.stylelint,
	},
	diagnostics_format = config.diagnostics_format,
})
