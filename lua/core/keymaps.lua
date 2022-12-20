-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Handy shortcuts
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>", { desc = "Write buffer" })

-- Write buffers
vim.keymap.set("n", "<Leader>bw", "<CMD>w!<CR>", { desc = "[W]rite Buffer" })
vim.keymap.set("n", "<Leader>bW", "<CMD>wa!<CR>", { desc = "[W]rite All Buffers" })

-- Close buffers
vim.keymap.set("n", "<Leader>bd", "<CMD>bd<CR>", { desc = "[D]elete buffer" })
vim.keymap.set("n", "<Leader>bD", "<CMD>%bd|e#|bd#<CR>", { desc = "[D]elete Other Buffers" })

-- Move through buffers
vim.keymap.set("n", "<C-h>", "<CMD>bp<CR>", { desc = "Previous Buffer", silent = true })
vim.keymap.set("n", "<C-l>", "<CMD>bn<CR>", { desc = "Next Buffer", silent = true })

-- Quit if not modified, else request confirmation
vim.keymap.set("n", "<C-q>", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_buf_get_option(bufnr, "modified")

	if modified then
		vim.ui.input({
			prompt = "You have unsaved changes. Quit anyway? (y/N) ",
		}, function(input)
			if input == "y" then
				vim.cmd("q!")
			end
		end)
	else
		vim.cmd("q!")
	end
end, { desc = "Quit" })
