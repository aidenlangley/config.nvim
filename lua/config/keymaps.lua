---@type utils
local utils = require("utils")

vim.keymap.set(
  "n",
  "<Leader>so",
  utils.cmd("e ~/.config/nvim/init.lua"),
  { desc = "Open `init.lua`" }
)

-- Move through buffers
vim.keymap.set("n", "[b", utils.cmd("bp"), { desc = "Previous (B)uffer", silent = true })
vim.keymap.set("n", "]b", utils.cmd("bn"), { desc = "Next (B)uffer", silent = true })

-- Close buffers
vim.keymap.set("n", "<Leader>D", utils.cmd("%bd|e#|bd#"), { desc = "(D)elete other bufferss" })

-- Write buffers
vim.keymap.set("n", "<C-s>", utils.cmd("w"), { desc = "Write buffer" })
vim.keymap.set("n", "<Leader>w", utils.cmd("w!"), { desc = "(W)rite buffer" })
vim.keymap.set("n", "<Leader>W", utils.cmd("wa!"), { desc = "(W)rite all" })

-- New buffer
vim.keymap.set("n", "<Leader>n", utils.cmd("enew"), { desc = "(N)ew buffer" })

-- Navigate windows
vim.keymap.set("n", "<C-h>", utils.cmd("wincmd h"), { desc = " window" })
vim.keymap.set("n", "<C-j>", utils.cmd("wincmd j"), { desc = " window" })
vim.keymap.set("n", "<C-k>", utils.cmd("wincmd k"), { desc = " window" })
vim.keymap.set("n", "<C-l>", utils.cmd("wincmd l"), { desc = " window" })

-- vim.keymap.set("n", "<C-Left>", utils.cmd("wincmd h"), { desc = " window" })
-- vim.keymap.set("n", "<C-Down>", utils.cmd("wincmd j"), { desc = " window" })
-- vim.keymap.set("n", "<C-Up>", utils.cmd("wincmd k"), { desc = " window" })
-- vim.keymap.set("n", "<C-Right>", utils.cmd("wincmd l"), { desc = " window" })

-- Quit if not modified, else request confirmation
vim.keymap.set("n", "<C-q>", utils.smart_quit, { desc = "(Q)uit" })

-- Code actions & formatting can function without a language server
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Code actions..." })
vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, { desc = "(F)ormat" })

local term_lazygit = utils.float_term("lazygit")
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

function M.lsp(_, _)
  vim.keymap.set("n", "<F2>", utils.cmd("Lspsaga rename"), { desc = "Rename" })
  vim.keymap.set("n", "K", utils.cmd("Lspsaga hover_doc ++quiet"), { desc = "Hover" })

  vim.keymap.set({ "n", "v" }, "<C-.>", utils.cmd("Lspsaga code_action"), {
    noremap = true,
    desc = "Code actions...",
  })

  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, "Goto (D)efinition")
  vim.keymap.set("n", "gd", utils.cmd("Lspsaga goto_definition"), { desc = "Goto (D)efinition" })
  vim.keymap.set("n", "gf", utils.cmd("Lspsaga lsp_finder"), { desc = "Goto (F)inder..." })
  vim.keymap.set("n", "<Leader>ls", utils.cmd("Lspsaga outline"), { desc = "View (S)ymbols" })

  vim.keymap.set("n", "<Leader>lD", vim.diagnostic.show, { desc = "Show (D)iagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next (D)iagnostic" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous (D)iagnostic" })

  vim.keymap.set("n", "<Leader>sl", utils.cmd("LspInfo"), { desc = "LSP: Info" })
end

return M
