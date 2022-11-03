local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		source_names = {},
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				buffer = "(Buffer)",
				emoji = "(Emoji)",
				nerdfont = "(Nerd)",
				nvim_lsp = "(LSP)",
				path = "(Path)",
			},
		}),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{
			name = "emoji",
			trigger_characters = { { ":" } },
		},
		{
			name = "nerdfont",
			trigger_characters = { { ":" } },
		},
		{
			name = "path",
			trigger_characters = { { "/" } },
		},
		{ name = "nvim_lsp" },
	},
	mapping = {
		-- Tab:
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),

		-- Vim style movement:
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),

		-- Arrow keys:
		["<Down>"] = cmp.mapping.select_next_item(),
		["<Up>"] = cmp.mapping.select_prev_item(),

		-- Complete:
		["<CR>"] = cmp.mapping.confirm(),
		["<C-Space>"] = cmp.mapping.confirm(),

		-- Abort:
		["<C-Esc>"] = cmp.mapping.abort(),
		["<C-e>"] = cmp.mapping.abort(),
	},
	enabled = function()
		-- Disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
})

cmp.setup.filetype({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

cmp.setup.filetype({ ":" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "cmdline" },
	},
})
