local tsb = require("telescope.builtin")
local wk = require("which-key")
local utils = require("utils")

local M = {}

function M.settings()
  local settings_path = "~/.config/nvim/init.lua"
  vim.keymap.set("n", "<Leader>;", utils.cmd("Alpha"), { desc = "Dashboard" })
  vim.keymap.set("n", "<Leader>sl", utils.cmd("LspInfo"), { desc = "LSP info" })
  vim.keymap.set("n", "<Leader>so", utils.cmd("e " .. settings_path), { desc = "Open `init.lua`" })

  wk.register({ s = { name = "[S]ettings..." } }, { prefix = "<Leader>" })
end

function M.buffers()
  -- Move through buffers
  vim.keymap.set("n", "<C-h>", utils.cmd("bp"), { desc = "Previous buffer", silent = true })
  vim.keymap.set("n", "<C-l>", utils.cmd("bn"), { desc = "Next buffer", silent = true })

  -- Close buffers
  vim.keymap.set("n", "<Leader>d", utils.cmd("bd"), { desc = "[D]elete buffer" })
  vim.keymap.set("n", "<Leader>D", utils.cmd("%bd|e#|bd#"), { desc = "[D]elete other bufferss" })

  -- Write buffers
  vim.keymap.set("n", "<C-s>", utils.cmd("w"), { desc = "Write buffer" })
  vim.keymap.set("n", "<Leader>w", utils.cmd("w!"), { desc = "[W]rite buffer" })
  vim.keymap.set("n", "<Leader>W", utils.cmd("wa!"), { desc = "[W]rite all" })

  -- New buffer
  vim.keymap.set("n", "<Leader>n", utils.cmd("enew"), { desc = "[N]ew buffer" })
end

function M.telescope()
  local function nmap(keys, func, desc)
    if desc then
      desc = "Telescope: " .. desc
    end

    vim.keymap.set("n", keys, func, { desc = desc })
  end

  nmap("<C-f>", tsb.live_grep, "Grep")
  nmap("<Leader>/", tsb.current_buffer_fuzzy_find, "Find")
  nmap("<Leader><Space>", tsb.buffers, "Buffers")
  nmap("ta", tsb.autocommands, "[A]utocommands")
  nmap("tc", tsb.commands, "[C]ommands")
  nmap("td", tsb.diagnostics, "[D]iagnostics")
  nmap("tf", tsb.find_files, "[F]iles")
  nmap("tg", tsb.live_grep, "[G]rep files")
  nmap("th", tsb.help_tags, "[H]elp")
  nmap("tH", tsb.highlights, "[H]ighlights")
  nmap("tH", tsb.command_history, "Command [H]istory")
  nmap("tk", tsb.keymaps, "[K]eymaps")
  nmap("tm", tsb.marks, "[M]arks")
  nmap("tp", require("telescope").extensions.projects.projects, "[P]rojects")
  nmap("tr", tsb.oldfiles, "[R]ecent files")
  nmap("tt", utils.cmd("Telescope"), "[T]elescope")

  wk.register({ t = { name = "[T]elescope..." } })
end

function M.git()
  local function nmap(keys, func, desc)
    if desc then
      desc = "Git: " .. desc
    end

    vim.keymap.set("n", keys, func, { desc = desc })
  end

  local term_lazygit = utils.float_term("lazygit")
  nmap("<Leader>gg", function()
    term_lazygit:toggle()
  end, "Lazy[G]it")

  nmap("<Leader>gb", tsb.git_branches, "[B]ranches")
  nmap("<Leader>gC", tsb.git_commits, "[C]ommits")
  nmap("<Leader>gs", tsb.git_status, "[S]tatus")
  nmap("<Leader>gS", tsb.git_stash, "[S]tash")

  wk.register({ g = { name = "[G]it..." } }, { prefix = "<Leader>", mode = { "n", "v" } })
end

function M.lsp(_, bufnr)
  local function nmap(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<F2>", vim.lsp.buf.rename, "Rename")
  nmap("K", vim.lsp.buf.hover, "Hover")

  nmap("gd", vim.lsp.buf.definition, "Goto [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "Goto [I]mplementation")
  nmap("gs", vim.lsp.buf.signature_help, "[S]ignature help")

  nmap("<Leader>ld", tsb.lsp_definitions, "View [D]efinitions")
  nmap("<Leader>li", tsb.lsp_implementations, "View [I]mplementations")
  nmap("<Leader>lr", tsb.lsp_references, "View [R]eferences")
  nmap("<Leader>ls", utils.cmd("SymbolsOutline"), "View [S]ymbols")
  nmap("<Leader>lt", tsb.lsp_type_definitions, "View [T]ype definitions")

  wk.register({ l = { name = "[L]SP..." } }, { prefix = "<Leader>", mode = { "n", "v" } })

  -- Diagnostics
  vim.keymap.set("n", "<Leader>t", utils.cmd("Trouble"), { desc = "[T]rouble" })
  nmap("]d", vim.diagnostic.goto_next, "Next diagnostic")
  nmap("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
end

-- Copy & paste
vim.keymap.set("v", "<C-c>", utils.cmd("'<,'>yank"), { desc = "Yank (copy)" })
vim.keymap.set("n", "<C-v>", utils.cmd("put"), { desc = "Put (paste)" })

-- Quit if not modified, else request confirmation
vim.keymap.set("n", "<C-q>", utils.smart_quit, { desc = "[Q]uit" })

-- Code actions & formatting can function without a language server
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "LSP: Code actions" })
vim.keymap.set(
  "n",
  "<Leader>f",
  require("utils.lsp.auto_format").format,
  { desc = "LSP: [F]ormat" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { desc = "Search forwards", expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { desc = "Search forwards", expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { desc = "Search forwards", expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { desc = "Search backwards", expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { desc = "Search backwards", expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { desc = "Search backwards", expr = true })

-- Move lines
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line up" })

M.buffers()
M.git()
M.settings()
M.telescope()

return M
