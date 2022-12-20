local null_ls = require("null-ls")
local config = require("core.config.null_ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with(config.configs.prettier_config),
		null_ls.builtins.diagnostics.eslint.with(config.configs.eslint_config),
	},
})
