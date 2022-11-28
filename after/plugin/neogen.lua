require("neogen").setup({
	enabled = true,
	snippet_engine = "luasnip",
	languages = {
		lua = { template = { annotation_convention = "ldoc" } },
		python = { template = { annotation_convention = "google_docstrings" } },
		rust = { template = { annotation_convention = "rustdoc" } },
		javascript = { template = { annotation_convention = "jsdoc" } },
		typescript = { template = { annotation_convention = "tsdoc" } },
	},
})
