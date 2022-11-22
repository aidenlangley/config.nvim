-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

local lsp = require("lsp")
lsp.setup_server("sumneko_lua", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				-- path = runtime_path,
			},
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})

local null_ls = require("null-ls")
lsp.setup_null_ls({
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.diagnostics.luacheck.with({
		extra_args = { "--config", ".luacheckrc" },
	}),
})
