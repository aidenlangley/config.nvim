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
		"cssls",
		"emmet_ls",
		"gopls",
		"html",
		"jsonls",
		"pyright",
		"rust_analyzer",
		"sumneko_lua",
		"svelte",
		"tailwindcss",
		"taplo",
		"tsserver",
		"volar",
		"yamlls",
	},
})

local M = {}

M.setup_server = function(server, opts)
	server = require("lspconfig")[server]
	opts = opts or {}
	opts["capabilities"] = require("cmp_nvim_lsp").default_capabilities()
	server.setup(opts)
	server.manager.try_add_wrapper(vim.api.nvim_get_current_buf())
end

M.prettier_config = {
	only_local = "node_modules/.bin",
	condition = function(utils)
		return utils.root_has_file({ "node_modules" })
	end,
}

M.eslint_config = {
	prefer_local = "node_modules/.bin",
	condition = function(utils)
		return utils.root_has_file({ "node_modules" })
	end,
}

M.diagnostics_format = "[#{c}] #{m} (#{s})"

M.setup_null_ls = function(sources)
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = sources,
		diagnostics_format = M.diagnostics_format,
	})
end

return M
