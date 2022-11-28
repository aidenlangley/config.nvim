local M = {}

--- [TODO:description]
-- @tparam [TODO:parameter] server
-- @tparam [TODO:parameter] opts
M.setup_server = function(server, opts)
	server = require("lspconfig")[server]
	opts = opts or {}
	opts["capabilities"] = require("cmp_nvim_lsp").default_capabilities()
	server.setup(opts)
	server.manager.try_add_wrapper(vim.api.nvim_get_current_buf())
end

--- [TODO:description]
-- @tparam [TODO:parameter] utils
-- @treturn [TODO:return]
M.prettier_config = {
	only_local = "node_modules/.bin",
	condition = function(utils)
		return utils.root_has_file({ "node_modules" })
	end,
}

--- [TODO:description]
-- @tparam [TODO:parameter] utils
-- @treturn [TODO:return]
M.eslint_config = {
	prefer_local = "node_modules/.bin",
	condition = function(utils)
		return utils.root_has_file({ "node_modules" })
	end,
}

--- [TODO:description]
M.diagnostics_format = "[#{c}] #{m} (#{s})"

--- [TODO:description]
-- @tparam [TODO:parameter] sources
M.setup_null_ls = function(sources)
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = sources,
		diagnostics_format = M.diagnostics_format,
	})
end

return M
