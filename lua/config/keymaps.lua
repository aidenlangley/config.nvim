---@module 'Util'
---@type Util
local Util = require("utils")

vim.keymap.set(
  "n",
  "<Leader>so",
  Util.cmd("e ~/.config/nvim/init.lua"),
  { desc = "Open `init.lua`" }
)

-- Move through buffers
vim.keymap.set("n", "[b", Util.cmd("bp"), { desc = "Previous (b)uffer", silent = true })
vim.keymap.set("n", "]b", Util.cmd("bn"), { desc = "Next (b)uffer", silent = true })

-- Close buffers
vim.keymap.set("n", "<Leader>D", Util.cmd("%bd|e#|bd#"), { desc = "(D)elete other bufferss" })

-- Write buffers
vim.keymap.set("n", "<C-s>", Util.cmd("w"), { desc = "Write buffer" })
vim.keymap.set("n", "<Leader>w", Util.cmd("w!"), { desc = "(W)rite buffer" })
vim.keymap.set("n", "<Leader>W", Util.cmd("wa!"), { desc = "(W)rite all" })

-- New buffer
vim.keymap.set("n", "<Leader>n", Util.cmd("enew"), { desc = "(N)ew buffer" })

-- Navigate windows
vim.keymap.set("n", "<C-h>", Util.cmd("wincmd h"), { desc = " window" })
vim.keymap.set("n", "<C-j>", Util.cmd("wincmd j"), { desc = " window" })
vim.keymap.set("n", "<C-k>", Util.cmd("wincmd k"), { desc = " window" })
vim.keymap.set("n", "<C-l>", Util.cmd("wincmd l"), { desc = " window" })

vim.keymap.set("n", "<C-Left>", Util.cmd("wincmd h"), { desc = " window" })
vim.keymap.set("n", "<C-Down>", Util.cmd("wincmd j"), { desc = " window" })
vim.keymap.set("n", "<C-Up>", Util.cmd("wincmd k"), { desc = " window" })
vim.keymap.set("n", "<C-Right>", Util.cmd("wincmd l"), { desc = " window" })

-- Quit if not modified, else request confirmation
vim.keymap.set("n", "<C-q>", Util.smart_quit, { desc = "(Q)uit" })

-- Code actions & formatting can function without a language server
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Code actions..." })
vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, { desc = "(F)ormat" })

local term_lazygit = Util.float_term("lazygit")
vim.keymap.set("n", "<Leader>gg", function()
  term_lazygit:toggle()
end, { desc = "Lazy(G)it" })

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

local M = {}

function M.lsp(_, bufnr)
  local function nmap(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<F2>", vim.lsp.buf.rename, "Rename")
  nmap("K", vim.lsp.buf.hover, "Hover")

  nmap("gd", vim.lsp.buf.definition, "Goto (D)efinition")
  nmap("gi", vim.lsp.buf.implementation, "Goto (I)mplementation")

  nmap("<Leader>lk", vim.diagnostic.open_float, "Show (d)iagnostic")
  nmap("]d", vim.diagnostic.goto_next, "Next (d)iagnostic")
  nmap("[d", vim.diagnostic.goto_prev, "Previous (d)iagnostic")

  vim.keymap.set("n", "<Leader>sl", Util.cmd("LspInfo"), { desc = "LSP: Info" })
end

return M
