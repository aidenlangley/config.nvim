local prettier_config = {
	extra_filetypes = { "yaml", "yml" },
	args = { "--no-bracket-spacing" },
}

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with(prettier_config),
		null_ls.builtins.diagnostics.yamllint,
	},
	diagnostics_format = require("core.config.null_ls").diagnostics_format,
})
