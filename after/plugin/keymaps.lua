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

local function xmap(key, action, desc)
	vim.keymap.set("x", key, action, {
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

-- Treehopper
vmap("m", require("tsht").nodes, "Treehopper nodes")

-- Telescope
nmap("ta", telescope("autocommands"), "Autocommands")
nmap("tb", cmd("JABSOpen"), "JABS")
nmap("tB", telescope("buffers"), "Buffers")
nmap("tc", telescope("commands"), "Commands")
nmap("tC", telescope("colorscheme"), "Colourschemes")
nmap("tf", telescope("fd"), "Find files")
nmap("tF", telescope("filetypes"), "Set filetype")
nmap("tgG", telescope("grep_string"), "Grep string")
nmap("tgb", telescope("git_branches"), "Git branches")
nmap("tgc", telescope("git_commits"), "Git commits")
nmap("tgg", telescope("live_grep"), "Live grep")
nmap("tgs", telescope("git_stash"), "Git stash")
nmap("tH", telescope("highlights"), "[TS] Highlights")
nmap("thc", telescope("command_history"), "Command history")
nmap("ths", telescope("search_history"), "Search history")
nmap("tht", telescope("help_tags"), "Help tags")
nmap("tj", telescope("jumplist"), "Jump list")
nmap("tk", telescope("keymaps"), "Keymaps")
nmap("tlr", telescope("lsp_references"), "References")
nmap("tld", telescope("lsp_definitions"), "Definitions")
nmap("tli", telescope("lsp_implementations"), "Implementations")
nmap("tlt", telescope("lsp_type_definitions"), "Type definitions")
nmap("to", telescope("oldfiles"), "Recent files")
nmap("tO", telescope("vim_options"), "Vim options")
nmap("tp", cmd("Telescope projects"), "Projects")
nmap("tr", telescope("registers"), "Registers")
nmap("tsd", telescope("lsp_document_symbols"), "Document symbols")
nmap("tsw", telescope("lsp_workspace_symbols"), "Workspace symbols")
nmap("tt", telescope("builtin"), "Telescope")
nmap("tT", telescope("treesitter"), "Treesitter")

-- Trouble
nmap("T", require("trouble").toggle, "Trouble")

-- Leader > other
nmap("<Leader>?", cmd("WhichKey"), "Help")
nmap("<Leader>;", cmd("Alpha"), "Dashboard")
nmap("<Leader>C", cmd("ColorizerToggle"), "Highlight colours")
nmap("<Leader>d", cmd("bd"), "Close")
nmap("<Leader>D", cmd("%bd|e#|bd#"), "Close all")
nmap("<Leader>e", cmd("NvimTreeToggle"), "Explorer")
nmap("<Leader>E", cmd("Dirbuf"), "Dirbuf")
nmap("<Leader>n", cmd("enew"), "New")
nmap("<Leader>s", cmd("split"), "Split")
nmap("<Leader>S", cmd("e ~/.config/nvim/init.lua"), "Settings")
nmap("<Leader>v", cmd("vsplit"), "Split vertically")
nmap("<Leader>w", cmd("w!"), "Save")
nmap("<Leader>W", cmd("wa!"), "Save all")
nmap("<Leader>q", utils.smart_quit, "Quit")

-- Git
wk_register("<Leader>g", "Git...")
nmap("<Leader>gb", gs.toggle_current_line_blame, "Blame")
nmap("<Leader>gd", gs.diffthis, "Diff selection")
nmap("<Leader>gh", gs.prev_hunk, "Previous hunk")
nmap("<Leader>gl", gs.next_hunk, "Next hunk")
nmap("<Leader>gp", gs.preview_hunk, "Preview")
nmap("<Leader>gr", gs.reset_hunk, "Reset hunk")
nmap("<Leader>gR", gs.reset_buffer, "Reset")
nmap("<Leader>gs", gs.stage_hunk, "Stage hunk")
nmap("<Leader>gS", gs.stage_buffer, "Stage")
nmap("<Leader>gu", gs.undo_stage_hunk, "Undo stage")
nmap("<Leader>gx", gs.toggle_deleted, "Show deleted")
vmap("<Leader>gr", cmd("Gitsigns reset_hunk"), "Reset selection")
vmap("<Leader>gs", cmd("Gitsigns stage_hunk"), "Stage selection")
nmap("<Leader>gB", function()
	gs.blame_line({ full = true })
end, "Blame (file)")
nmap("<Leader>gD", function()
	gs.diffthis("~")
end, "Diff (file)")
nmap("<Leader>gg", function()
	require("FTerm")
		:new({
			ft = "fterm_lazygit",
			cmd = "lazygit",
		})
		:toggle()
end, "Diff selection")

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

-- Treesitter
nmap("<Leader>t", "", "")

-- Syntax tree surfer
-- Selection
nmap("vu", function()
	require("syntax-tree-surfer").move("n", true)
end, "Move node up")
nmap("vd", function()
	require("syntax-tree-surfer").move("n", false)
end, "Move node down")
nmap("vx", function()
	require("syntax-tree-surfer").select()
end, "Swap node")
nmap("vn", function()
	require("syntax-tree-surfer").select_current_node()
end, "Select current node")
nmap("vo", function()
	require("syntax-tree-surfer").go_to_top_node_and_execute_commands(
		false,
		{ "normal! O", "normal! O", "startinsert" }
	)
end, "?")

-- Navigation
xmap("J", function()
	require("syntax-tree-surfer").surf("next", "visual")
end, "Move to next")
xmap("K", function()
	require("syntax-tree-surfer").surf("prev", "visual")
end, "Move to previous")
xmap("H", function()
	require("syntax-tree-surfer").surf("parent", "visual")
end, "Move to parent")
xmap("L", function()
	require("syntax-tree-surfer").surf("child", "visual")
end, "Move to child")

-- Swapping
xmap("<C-j>", function()
	require("syntax-tree-surfer").surf("next", "visual", true)
end, "Swap with next")
xmap("<C-k>", function()
	require("syntax-tree-surfer").surf("prev", "visual", true)
end, "Swap with previous")

-- Packer
wk_register("<Leader>p", "Packer...")
nmap("<Leader>pc", cmd("PackerClean"), "Clean")
nmap("<Leader>pC", cmd("PackerCompile"), "Compile")
nmap("<Leader>pi", cmd("PackerInstall"), "Install")
nmap("<Leader>ps", cmd("PackerSync"), "Sync")
nmap("<Leader>pS", cmd("PackerStatus"), "Status")

-- Zen mode
nmap("Z", cmd("ZenMode"), "Toggle zen mode")

-- Terminal
nmap("<C-t>", require("FTerm").toggle, "Toggle terminal")
vim.keymap.set("t", "<C-t>", require("FTerm").toggle, {
	desc = "Toggle terminal",
	silent = true,
	noremap = true,
})
