--- [TODO:description]
-- @tparam [TODO:parameter] modes
-- @tparam [TODO:parameter] key
-- @tparam [TODO:parameter] action
-- @tparam [TODO:parameter] desc
-- @tparam [TODO:parameter] opts
local function keymap(modes, key, action, desc, opts)
	opts = opts or {}
	opts.desc = desc
	opts.silent = opts.silent or true
	opts.noremap = opts.noremap or opts.remap ~= true or true
	opts.remap = opts.remap or opts.noremap ~= false or false
	vim.keymap.set(modes, key, action, opts)
end

--- Wraps string in <CMD> & <CR>
-- @tparam [TODO:parameter] command
-- @treturn [TODO:return]
local function cmd(command)
	return "<CMD>" .. command .. "<CR>"
end

--- Spawn a terminal - doesn't run `cmd` until it's opened.
-- @tparam string Command to run when opened
-- @treturn Terminal
local function term(command)
	return require("toggleterm.terminal").Terminal:new({
		hidden = true,
		direction = "float",
		dir = "git_dir",
		cmd = command,
	})
end

-- Terminals
local term_ctop = term("ctop")
local term_lazygit = term("lazygit")

--- [TODO:description]
local function toggle_term_ctop()
	term_ctop:toggle()
end

--- [TODO:description]
local function toggle_term_git()
	term_lazygit:toggle()
end

-- The maps start after requiring dependencies
local wk = require("which-key")
local ng = require("neogen")
local gs = require("gitsigns")
local sts = require("syntax-tree-surfer")
local utils = require("utils")

-- Movement
keymap("n", "<C-h>", cmd("bp"), "Next buffer")
keymap("n", "<C-l>", cmd("bn"), "Previous buffer")
keymap("n", "<C-Left>", cmd("bp"), "Next buffer")
keymap("n", "<C-Right>", cmd("bn"), "Previous buffer")

wk.register({ ["<C-b>"] = "Buffers..." })
keymap("n", "<C-b>h", cmd("bp"), "Next buffer")
keymap("n", "<C-b>l", cmd("bn"), "Previous buffer")

-- Save/close/quit buffers/windows
keymap("n", "<C-s>", cmd("w"), "Save")
keymap("n", "<C-q>", utils.smart_quit, "Quit")

-- LSP
-- Allow remapping, sometimes individual language server wants to do things
-- differently.
keymap("n", "<C-.>", vim.lsp.buf.hover, "[LSP] Hover")
keymap("n", "<C-Space>", vim.lsp.buf.code_action, "[LSP] Actions")
keymap("n", "<F2>", vim.lsp.buf.rename, "[LSP] Rename")

-- Treehopper
keymap("v", "m", require("tsht").nodes, "Treehopper nodes")

-- Telescope
wk.register({ ["t"] = { name = "Telescope..." } })
keymap("n", "ta", cmd("Telescope autocommands"), "Autocommands")
keymap("n", "tb", cmd("JABSOpen"), "JABS")
keymap("n", "tB", cmd("Telescope buffers"), "Buffers")
keymap("n", "tc", cmd("Telescope commands"), "Commands")
keymap("n", "tC", cmd("Telescope colorscheme"), "Colourschemes")
keymap("n", "tf", cmd("Telescope fd"), "Find files")
keymap("n", "tF", cmd("Telescope filetypes"), "Set filetype")
keymap("n", "tgG", cmd("Telescope grep_string"), "Grep string")
keymap("n", "tgb", cmd("Telescope git_branches"), "Git branches")
keymap("n", "tgc", cmd("Telescope git_commits"), "Git commits")
keymap("n", "tgg", cmd("Telescope live_grep"), "Live grep")
keymap("n", "tgs", cmd("Telescope git_stash"), "Git stash")
keymap("n", "tH", cmd("Telescope highlights"), "Highlights")
keymap("n", "thc", cmd("Telescope command_history"), "Command history")
keymap("n", "ths", cmd("Telescope search_history"), "Search history")
keymap("n", "tht", cmd("Telescope help_tags"), "Help tags")
keymap("n", "tj", cmd("Telescope jumplist"), "Jump list")
keymap("n", "tk", cmd("Telescope keymaps"), "Keymaps")
keymap("n", "tlr", cmd("Telescope lsp_references"), "References")
keymap("n", "tld", cmd("Telescope lsp_definitions"), "Definitions")
keymap("n", "tli", cmd("Telescope lsp_implementations"), "Implementations")
keymap("n", "tlt", cmd("Telescope lsp_type_definitions"), "Type definitions")
keymap("n", "tm", cmd("Telescope man_pages"), "Man pages")
keymap("n", "to", cmd("Telescope oldfiles"), "Recent files")
keymap("n", "tO", cmd("Telescope vim_options"), "Vim options")
keymap("n", "tp", cmd("Telescope projects theme=dropdown"), "Projects")
keymap("n", "tsd", cmd("Telescope lsp_document_symbols"), "Document symbols")
keymap("n", "tsw", cmd("Telescope lsp_workspace_symbols"), "Workspace symbols")
keymap("n", "tS", cmd("SearchSession"), "Sessions")
keymap("n", "tt", cmd("Telescope builtin"), "Telescope")
keymap("n", "tT", cmd("Telescope treesitter"), "Treesitter")
keymap({ "n", "v" }, "tr", cmd("Telescope registers"), "Registers")

-- Trouble
keymap("n", "T", require("trouble").toggle, "Trouble")

-- Leader > other
keymap("n", "<Leader>?", cmd("WhichKey"), "Help")
keymap("n", "<Leader>;", cmd("Alpha"), "Dashboard")
keymap("n", "<Leader>C", cmd("ColorizerToggle"), "Highlight colours")
keymap("n", "<Leader>d", cmd("bd"), "Close")
keymap("n", "<Leader>D", cmd("%bd|e#|bd#"), "Close all")
keymap("n", "<Leader>e", cmd("NvimTreeToggle"), "Explorer")
keymap("n", "<Leader>E", cmd("Dirbuf"), "Dirbuf")
keymap("n", "<Leader>n", cmd("enew"), "New")
keymap("n", "<Leader>s", cmd("split"), "Split")
keymap("n", "<Leader>S", cmd("e ~/.config/nvim/init.lua"), "Settings")
keymap("n", "<Leader>v", cmd("vsplit"), "Split vertically")
keymap("n", "<Leader>w", cmd("w!"), "Save")
keymap("n", "<Leader>W", cmd("wa!"), "Save all")
keymap("n", "<Leader>q", utils.smart_quit, "Quit")
keymap("n", "<Leader>c", toggle_term_ctop, "ctop")
keymap({ "n", "v" }, "<Leader>R", cmd("SnipRun"), "Run code")

-- Git
wk.register({ ["<Leader>g"] = { name = "Git..." } })
keymap("n", "<Leader>gb", gs.toggle_current_line_blame, "Blame")
keymap("n", "<Leader>gd", gs.diffthis, "Diff")
keymap("n", "<Leader>gh", gs.prev_hunk, "Previous hunk")
keymap("n", "<Leader>gl", gs.next_hunk, "Next hunk")
keymap("n", "<Leader>gp", gs.preview_hunk, "Preview")
keymap("n", "<Leader>gr", gs.reset_hunk, "Reset hunk")
keymap("n", "<Leader>gR", gs.reset_buffer, "Reset")
keymap("n", "<Leader>gs", gs.stage_hunk, "Stage hunk")
keymap("n", "<Leader>gS", gs.stage_buffer, "Stage")
keymap("n", "<Leader>gu", gs.undo_stage_hunk, "Undo stage")
keymap("n", "<Leader>gx", gs.toggle_deleted, "Show deleted")
keymap("n", "<Leader>gg", toggle_term_git, "lazygit")
keymap({ "n", "v" }, "<Leader>gr", cmd("Gitsigns reset_hunk"), "Reset selection")
keymap({ "n", "v" }, "<Leader>gs", cmd("Gitsigns stage_hunk"), "Stage selection")

-- LSP
wk.register({ ["<Leader>l"] = { name = "LSP..." } })
keymap("n", "<Leader>la", vim.lsp.buf.code_action, "Actions")
keymap("n", "<Leader>ld", vim.lsp.buf.definition, "Definition")
keymap("n", "<Leader>lD", vim.lsp.buf.declaration, "Declaration")
keymap("n", "<Leader>li", vim.lsp.buf.implementation, "Implementation")
keymap("n", "<Leader>lf", vim.lsp.buf.format, "Format")
keymap("n", "<Leader>lh", vim.lsp.buf.hover, "Hover")
keymap("n", "<Leader>lr", vim.lsp.buf.references, "References")
keymap("n", "<Leader>lR", vim.lsp.buf.rename, "Rename")
keymap("n", "<Leader>ls", vim.lsp.buf.signature_help, "Signature")
keymap("n", "<Leader>lt", vim.lsp.buf.type_definition, "Type")
keymap("n", "<Leader>lg", vim.diagnostic.open_float, "Diagnostic")
keymap("n", "<Leader>lh", vim.diagnostic.goto_prev, "Previous diagnostic")
keymap("n", "<Leader>ll", vim.diagnostic.goto_next, "Next diagnostic")
keymap("n", "<Leader>lI", cmd("LspInfo"), "LSP info")
keymap("n", "<Leader>lM", cmd("Mason"), "Mason")
keymap("n", "<Leader>lN", cmd("NullLsInfo"), "null-ls info")
keymap("n", "<Leader>lS", cmd("SymbolsOutline"), "Symbols")

--- [TODO:description]
local function ng_gen()
	ng.generate({})
end

--- [TODO:description]
local function ng_gen_class()
	ng.generate({ type = "class" })
end

--- [TODO:description]
local function ng_gen_func()
	ng.generate({ type = "func" })
end

--- [TODO:description]
local function ng_gen_file()
	ng.generate({ type = "file" })
end

--- [TODO:description]
local function ng_gen_type()
	ng.generate({ type = "type" })
end

-- Neogen
wk.register({ ["gd"] = { name = "Document..." } })
keymap("n", "gdd", ng_gen, "Generate documentation")
keymap("n", "gdc", ng_gen_class, "Document class")
keymap("n", "gdf", ng_gen_func, "Document function")
keymap("n", "gdF", ng_gen_file, "Document file")
keymap("n", "gdt", ng_gen_type, "Document type")

-- Treesitter
wk.register({ ["<Leader>t"] = { name = "Treesitter..." } })
wk.register({ ["<Leader>tx"] = { name = "Swap..." } })
wk.register({ ["<Leader>tp"] = { name = "Peek..." } })
keymap("n", "<Leader>t", "", "")

--- [TODO:description]
local function sts_move_up()
	sts.move("n", true)
end

--- [TODO:description]
local function sts_move_down()
	sts.move("n", false)
end

--- [TODO:description]
local function sts_select()
	sts.select()
end

--- [TODO:description]
local function sts_select_current()
	sts.select_current_node()
end

--- [TODO:description]
local function sts_top_node()
	sts.go_to_top_node_and_execute_commands(false, {
		"normal! O",
		"normal! O",
		"startinsert",
	})
end

--- [TODO:description]
local function sts_surf_next()
	sts.surf("next", "visual")
end

--- [TODO:description]
local function sts_surf_prev()
	sts.surf("prev", "visual")
end

--- [TODO:description]
local function sts_surf_child()
	sts.surf("child", "visual")
end

--- [TODO:description]
local function sts_surf_parent()
	sts.surf("parent", "visual")
end

--- [TODO:description]
local function sts_surf_next_swap()
	sts.surf("next", "visual", true)
end

--- [TODO:description]
local function sts_surf_prev_swap()
	sts.surf("prev", "visual", true)
end

-- Syntax tree surfer
-- Selection
keymap("n", "vu", sts_move_up, "Move node up")
keymap("n", "vd", sts_move_down, "Move node down")
keymap("n", "vx", sts_select, "Select node")
keymap("n", "vn", sts_select_current, "Select current node")
keymap("n", "vo", sts_top_node, "Go to top node & insert")

-- Navigation
keymap("x", "J", sts_surf_next, "Move to next")
keymap("x", "K", sts_surf_prev, "Move to previous")
keymap("x", "H", sts_surf_child, "Move to child")
keymap("x", "L", sts_surf_parent, "Move to parent")

-- Swapping
keymap("x", "<C-j>", sts_surf_next_swap, "Swap with next")
keymap("x", "<C-k>", sts_surf_prev_swap, "Swap with previous")

-- Packer
wk.register({ ["<Leader>p"] = { name = "Packer..." } })
keymap("n", "<Leader>pc", cmd("PackerClean"), "Clean")
keymap("n", "<Leader>pC", cmd("PackerCompile"), "Compile")
keymap("n", "<Leader>pi", cmd("PackerInstall"), "Install")
keymap("n", "<Leader>ps", cmd("PackerSync"), "Sync")
keymap("n", "<Leader>pS", cmd("PackerStatus"), "Status")
keymap("n", "<Leader>pu", cmd("PackerUpdate --preview"), "Update")

-- Zen mode
keymap("n", "Z", cmd("ZenMode"), "Toggle zen mode")

-- Terminal
keymap("n", "<C-t>", cmd("ToggleTerm"), "Toggle terminal")
keymap("t", "<C-t>", cmd("ToggleTerm"), {
	desc = "Toggle terminal",
	silent = true,
	noremap = true,
})
