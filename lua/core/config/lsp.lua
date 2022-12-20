local M = {}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
M.on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
end

-- Set up mason so it can manage external tooling
require("mason").setup()

-- nvim-cmp supports additional completion capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({ automatic_installation = true })

-- Set up handlers for language servers
mason_lspconfig.setup_handlers({
	-- Default handler
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = M.capabilities,
			on_attach = M.on_attach,
		})
	end,
	["sumneko_lua"] = function()
		-- Make runtime files discoverable to the server
		local runtime_path = vim.split(package.path, ";")
		table.insert(runtime_path, "lua/?.lua")
		table.insert(runtime_path, "lua/?/init.lua")

		require("lspconfig").sumneko_lua.setup({
			capabilities = M.capabilities,
			on_attach = M.on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = runtime_path,
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					telemetry = { enable = false },
				},
			},
		})
	end,
	["gopls"] = function()
		require("lspconfig").gopls.setup({
			capabilities = M.capabilities,
			on_attach = M.on_attach,
			settings = {
				gopls = {
					gofumpt = true,
				},
			},
		})
	end,
	["volar"] = function()
		require("lspconfig").volar.setup({
			capabilities = M.capabilities,
			on_attach = M.on_attach,
			filetypes = {
				"typescript",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"vue",
				"json",
			},
		})
	end,
})

-- Turn on lsp status information
require("fidget").setup({
	window = { blend = 95 },
})

-- Allows commenting code via `gc`
require("Comment").setup()

-- Completes pairs of ({[]})
require("nvim-autopairs").setup()

return M
