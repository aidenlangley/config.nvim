local utils = require("utils")
local tsb_status, tsb = pcall(require, "telescope.builtin")
local wk_status, wk = pcall(require, "which-key")
local _, gs = pcall(require, "gitsigns")

-- Normal mode map, with silent & noremap flags.
local function nmap(key, action, desc)
	vim.keymap.set("n", key, action, {
		desc = desc,
		silent = true,
		noremap = true,
	})
end

-- Visual mode map, same as nmap.
local function vmap(key, action, desc)
	vim.keymap.set("v", key, action, {
		desc = desc,
		silent = true,
		noremap = true,
	})
end

-- Terminal mode map, same as nmap
local function tmap(key, action, desc)
	vim.keymap.set("t", key, action, {
		desc = desc,
		silent = true,
		noremap = true,
	})
end

-- Wraps string in <CMD> & <CR>
local function cmd(command)
	return "<CMD>" .. command .. "<CR>"
end

-- Wraps wk.register(). Checks if pcall was successful, just in case we're not
-- using which-key.
local function wk_register(prefix, name)
	if wk_status ~= false then
		wk.register({ [prefix] = { name = name } })
	end
end

-- Wraps telescope.builtin. Checks if pcall was successful, in case we're not
-- running telescope.
local function telescope(builtin)
	if tsb_status ~= false then
		return tsb[builtin]
	end
end

-- Movement
nmap("<C-h>", cmd("bp"), "Next buffer")
nmap("<C-j>", cmd("wincmd W"), "Next window")
nmap("<C-k>", cmd("wincmd w"), "Previous window")
nmap("<C-l>", cmd("bn"), "Previous buffer")

-- Save/close/quit buffers/windows
nmap("<C-s>", cmd("w"), "Save")
nmap("<C-q>", utils.smart_quit, "Quit")

-- LSP
nmap("<C-.>", vim.lsp.buf.hover, "[LSP] Peek")
nmap("<C-Space>", vim.lsp.buf.code_action, "[LSP] Actions")

-- Terminal
tmap("<Esc>", cmd("ToggleTerm"), "Toggle terminal")

-- Leader > other
nmap("<Leader>?", cmd("WhichKey"), "Help")
nmap("<Leader>c", cmd("e ~/.config/nvim/init.lua"), "Settings")
nmap("<Leader>d", cmd("bd"), "Close")
nmap("<Leader>D", cmd("%bd|e#|bd#"), "Close all")
nmap("<Leader>e", cmd("Dirbuf"), "Dirbuf")
nmap("<Leader>n", cmd("enew"), "New")
nmap("<Leader>s", cmd("split"), "Split")
nmap("<Leader>S", cmd("vsplit"), "Split vertically")
nmap("<Leader>w", cmd("w!"), "Save")
nmap("<Leader>W", cmd("wa!"), "Save all")
nmap("<Leader>q", utils.smart_quit, "Quit")
nmap("<Leader>b", telescope("buffers"), "Find")
nmap("<Leader>/", telescope("keymaps"), "Keymaps")
nmap("<Leader>f", telescope("fd"), "Find files")
nmap("<Leader>g", telescope("live_grep"), "Live grep")

-- Git
wk_register("<Leader>g", "Git...")
nmap("<Leader>gb", gs.toggle_current_line_blame, "Blame")
nmap("<Leader>gB", function()
	gs.blame_line({ full = true })
end, "Blame (file)")
nmap("<Leader>gd", gs.diffthis, "Diff selection")
nmap("<Leader>gD", function()
	gs.diffthis("~")
end, "Diff (file)")
nmap("<Leader>gh", gs.prev_hunk, "Previous hunk")
nmap("<Leader>gl", gs.next_hunk, "Next hunk")
nmap("<Leader>gp", gs.preview_hunk, "Preview")
nmap("<Leader>gr", gs.reset_hunk, "Reset hunk")
nmap("<Leader>gR", gs.reset_buffer, "Reset")
nmap("<Leader>gs", gs.stage_hunk, "Stage hunk")
nmap("<Leader>gS", gs.stage_buffer, "Stage")
nmap("<Leader>gu", gs.undo_stage_hunk, "Undo stage")
nmap("<Leader>gx", gs.toggle_deleted, "Show deleted")
nmap("<Leader>gg", cmd("TermExec cmd=lazygit direction=float"), "lazygit")
vmap("<Leader>gr", cmd("Gitsigns reset_hunk"), "Reset selection")
vmap("<Leader>gs", cmd("Gitsigns stage_hunk"), "Stage selection")

-- LSP
wk_register("<Leader>l", "LSP...")
nmap("<Leader>la", vim.lsp.buf.code_action, "Actions")
nmap("<Leader>ld", vim.lsp.buf.definition, "Definition")
nmap("<Leader>lD", vim.lsp.buf.declaration, "Declaration")
nmap("<Leader>li", vim.lsp.buf.implementation, "Implementation")
nmap("<Leader>lf", vim.lsp.buf.format, "Format")
nmap("<Leader>lh", vim.lsp.buf.hover, "Hover")
nmap("<Leader>lr", vim.lsp.buf.references, "References")
nmap("<Leader>lR", vim.lsp.buf.rename, "Rename")
nmap("<Leader>ls", vim.lsp.buf.signature_help, "Signature")
nmap("<Leader>lt", vim.lsp.buf.type_definition, "Type")
nmap("<Leader>lg", vim.diagnostic.open_float, "Diagnostic")
nmap("<Leader>lh", vim.diagnostic.goto_prev, "Previous diagnostic")
nmap("<Leader>ll", vim.diagnostic.goto_next, "Next diagnostic")
nmap("<Leader>lI", cmd("LspInfo"), "LSP Info")
nmap("<Leader>lM", cmd("Mason"), "Mason")
nmap("<Leader>lN", cmd("NullLsInfo"), "NullLs Info")
nmap("<Leader>lS", cmd("SymbolsOutline"), "Symbols")
nmap("<Leader>lT", cmd("TroubleToggle"), "Trouble")

-- Packer
wk_register("<Leader>p", "Packer...")
nmap("<Leader>pc", cmd("PackerClean"), "Clean")
nmap("<Leader>pC", cmd("PackerCompile"), "Compile")
nmap("<Leader>pi", cmd("PackerInstall"), "Install")
nmap("<Leader>ps", cmd("PackerSync"), "Sync")
nmap("<Leader>pS", cmd("PackerStatus"), "Status")

-- Telescope
wk_register("<Leader>t", "Telescope...")
nmap("<Leader>ta", telescope("builtin"), "All...")
nmap("<Leader>th", telescope("help_tags"), "Help")
nmap("<Leader>tk", telescope("keymaps"), "Keymaps")
nmap("<Leader>tm", telescope("marks"), "Marks")
nmap("<Leader>tr", telescope("oldfiles"), "Recent files")
nmap("<Leader>tR", telescope("reloader"), "Reload plugin")
nmap("<Leader>tv", telescope("vim_options"), "Vim options")
