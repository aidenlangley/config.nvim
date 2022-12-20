local wk = require("which-key")
wk.setup({
	key_labels = {
		["<space>"] = "SPC",
		["<Space>"] = "SPC",
		["<c-space>"] = "C-SPC",
		["<C-Space>"] = "C-SPC",
		["<cr>"] = "CR",
		["<CR>"] = "CR",
		["<tab>"] = "TAB",
		["<Tab>"] = "TAB",
		["<s-tab>"] = "S-TAB",
		["<S-Tab>"] = "S-TAB",
		["<backspace>"] = "<-",
		["<Backspace>"] = "<-",
	},
})

wk.register({
	{ b = { name = "[B]uffer..." } },
	{ c = { name = "[C]ode..." } },
	{ d = { name = "[D]ocument..." } },
	{ g = { name = "[G]enerate..." } },
	{ p = { name = "[P]acker..." } },
	{ s = { name = "[S]earch..." } },
	{ w = { name = "[W]orkspace..." } },
	{ ["<Backspace>"] = { name = "Show all..." } },
}, { prefix = "<Leader>" })
