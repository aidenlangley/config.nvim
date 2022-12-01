local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local neogen = require("neogen")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

if cmp ~= nil then
	local select_next = function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif neogen.jumpable() then
			neogen.jump_next()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end

	local select_prev = function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		elseif neogen.jumpable(true) then
			neogen.jump_prev()
		else
			fallback()
		end
	end

	cmp.setup({
		completion = { completeopt = "menu,menuone,noinsert" },
		view = { entries = "native" },
		formatting = {
			source_names = {},
			format = lspkind.cmp_format({
				mode = "symbol_text",
				menu = {
					buffer = "(Buffer)",
					calc = "(Calc)",
					emoji = "(Emoji)",
					nerdfont = "(Nerd)",
					nvim_lua = "(Lua)",
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
			{ name = "buffer" },
			{ name = "calc" },
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
		},
		mapping = cmp.mapping.preset.insert({
			-- Tab:
			["<Tab>"] = cmp.mapping(select_next, { "i", "s", "c" }),
			["<S-Tab>"] = cmp.mapping(select_prev, { "i", "s", "c" }),

			-- Vim style movement:
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-K>"] = cmp.mapping.select_prev_item(),

			-- Arrow keys:
			["<Down>"] = cmp.mapping.select_next_item(),
			["<Up>"] = cmp.mapping.select_prev_item(),

			-- Complete:
			["<CR>"] = cmp.mapping.confirm(),
			["<C-Space>"] = cmp.mapping.confirm(),
		}),
		enabled = function()
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			else
				local context = require("cmp.config.context")
				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end
		end,
	})

	-- Sets up Tab completion in command mode! More important than it first seems.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end
