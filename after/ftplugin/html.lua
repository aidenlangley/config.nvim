local lsp = require("lsp")
lsp.setup_server("html", {})
lsp.setup_server("emmet_ls", {})

local null_ls = require("null-ls")
null_ls.setup({
	sources = { null_ls.builtins.prettier.with(lsp.prettier_config) },
})
