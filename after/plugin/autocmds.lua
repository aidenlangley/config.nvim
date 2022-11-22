-- Helper function to create autocmd group then autocmd.
local create_autocmd = function(on_event, autocmd)
	autocmd.group = vim.api.nvim_create_augroup(autocmd.group, { clear = false })
	vim.api.nvim_create_autocmd(on_event, autocmd)
end

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
create_autocmd("BufWritePre", {
	group = "lsp_format_on_save",
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ timeout_ms = 1000, filter = lsp_filter })
	end,
})

-- zsh = sh basically.
create_autocmd("BufEnter", {
	group = "zsh_to_sh",
	pattern = { "*.zsh", ".zshrc", ".zimrc" },
	command = "setfiletype sh",
})

-- Whenever we save init.lua, re-compile packer.
create_autocmd("BufWritePost", {
	group = "packer",
	pattern = vim.fn.expand("$MYVIMRC"),
	command = "source <afile> | PackerCompile",
})

-- Twilight - toggle on insert enter & leave
create_autocmd("InsertEnter", {
	group = "twilight",
	command = "TwilightEnable",
})
create_autocmd("InsertLeave", {
	group = "twilight",
	command = "TwilightDisable",
})
