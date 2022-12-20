local neogen = require("neogen")

neogen.setup({
	snippet_engine = "luasnip",
})

-- Generate documentation based on location in document
vim.keymap.set("n", "<Leader>gg", neogen.generate, { desc = "Neogen: [G]enerate doc" })

-- Generate function documentation
vim.keymap.set("n", "<Leader>gf", function()
	neogen.generate({ type = "func" })
end, { desc = "Neogen: [G]enerate [F]unction doc" })

-- Generate class documentation
vim.keymap.set("n", "<Leader>gc", function()
	neogen.generate({ type = "class" })
end, { desc = "Neogen: [G]enerate [C]lass doc" })

-- Generate type documentation
vim.keymap.set("n", "<Leader>gt", function()
	neogen.generate({ type = "type" })
end, { desc = "Neogen: [G]enerate [T]ype doc" })

-- Generate file documentation
vim.keymap.set("n", "<Leader>gF", function()
	neogen.generate({ type = "file" })
end, { desc = "Neogen: [G]enerate [F]ile doc" })
