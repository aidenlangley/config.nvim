local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.luacheck.with({
			extra_args = { "--config", ".luacheckrc" },
		}),
	},
	diagnostics_format = require("core.config.null_ls").diagnostics_format,
})
