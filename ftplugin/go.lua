local lsp = require("plugins.config.lsp")
lsp.setup_server("gopls", { settings = { gopls = { gofumpt = true } } })

local null_ls = require("null-ls")
lsp.setup_null_ls({
	-- null_ls.builtins.formatting.gofmt,
	null_ls.builtins.formatting.gofumpt,
	null_ls.builtins.formatting.golines.with({
		extra_args = { "-m", "80", "-t", "2", "--base-formatter", "gofumpt" },
	}),
})
