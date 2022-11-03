-- Format with null-ls over LSP
local function lsp_filter(client)
	local n = require("null-ls")
	local s = require("null-ls.sources")
	local available = s.get_available(vim.bo.filetype, n.methods.FORMATTING)

	if #available > 0 then
		return client.name == "null-ls"
	elseif client.supports_method("textDocument/formatting") then
		return true
	else
		return false
	end
end

-- Automatically format on save. To circumvent this behaviour, the autocmd
-- will need to be disabled ad-hoc.
vim.api.nvim_create_augroup("lsp_format_on_save", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "lsp_format_on_save",
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ timeout_ms = 1000, filter = lsp_filter })
	end,
})

-- zsh = sh basically
vim.api.nvim_create_augroup("zsh_to_sh", {})
vim.api.nvim_create_autocmd("BufEnter", {
	group = "zsh_to_sh",
	pattern = { "*.zsh", ".zshrc", ".zimrc" },
	command = "setfiletype sh",
})

vim.api.nvim_create_augroup("carbon", {})
vim.api.nvim_create_autocmd("WinEnter", {
	group = "carbon",
	pattern = { "carbon" },
	command = "set nonumber",
})
