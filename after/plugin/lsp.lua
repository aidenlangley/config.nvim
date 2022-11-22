require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local mlspconfig = require("mason-lspconfig")
mlspconfig.setup({
	automatic_installation = true,
	ensure_installed = {
		"bashls",
		"jsonls",
		"taplo",
		"yamlls",
	},
})
