local utils = require("utils")

vim.keymap.set(
  "n",
  "<Leader>so",
  utils.cmd("e ~/.config/nvim/init.lua"),
  { desc = "Open `init.lua`" }
)

-- Move through buffers
vim.keymap.set(
  "n",
  "{",
  utils.cmd("bp"),
  { desc = "Previous buffer", silent = true }
)
vim.keymap.set(
  "n",
  "}",
  utils.cmd("bn"),
  { desc = "Next buffer", silent = true }
)

-- Close buffers
vim.keymap.set(
  "n",
  "<Leader>D",
  utils.cmd("%bd|e#|bd#"),
  { desc = "(D)elete other bufferss" }
)

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

-- Quit if not modified, else request confirmation
vim.keymap.set("n", "<C-q>", utils.smart_quit, { desc = "(Q)uit" })

-- Code actions & formatting can function without a language server
vim.keymap.set("n", "<C-.>", function()
  vim.lsp.buf.code_action()
end, { desc = "Code actions..." })

vim.keymap.set("n", "<Leader>gg", function()
  utils.float_term("lazygit"):toggle()
end, { desc = "Lazy(G)it" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set(
  "n",
  "n",
  "'Nn'[v:searchforward]",
  { desc = "Search forwards", expr = true }
)
vim.keymap.set(
  "x",
  "n",
  "'Nn'[v:searchforward]",
  { desc = "Search forwards", expr = true }
)
vim.keymap.set(
  "o",
  "n",
  "'Nn'[v:searchforward]",
  { desc = "Search forwards", expr = true }
)
vim.keymap.set(
  "n",
  "N",
  "'nN'[v:searchforward]",
  { desc = "Search backwards", expr = true }
)
vim.keymap.set(
  "x",
  "N",
  "'nN'[v:searchforward]",
  { desc = "Search backwards", expr = true }
)
vim.keymap.set(
  "o",
  "N",
  "'nN'[v:searchforward]",
  { desc = "Search backwards", expr = true }
)

-- Move lines
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set(
  "v",
  "<M-j>",
  ":m '>+1<CR>gv=gv",
  { desc = "Move selection down" }
)
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line up" })

local M = {}

function M.lsp(_, bufnr)
  vim.keymap.set(
    "n",
    "<F2>",
    vim.lsp.buf.rename,
    { desc = "Rename", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "K",
    vim.lsp.buf.hover,
    { desc = "Hover", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "gs",
    vim.lsp.buf.signature_help,
    { desc = "(S)ignature help", buffer = bufnr }
  )

  vim.keymap.set(
    "n",
    "gi",
    utils.cmd("Telescope lsp_implementations"),
    { desc = "Goto (I)mplementations...", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "gr",
    utils.cmd("Telescope lsp_references"),
    { desc = "Goto (R)eferences...", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "gd",
    vim.lsp.buf.definition,
    { desc = "Goto (D)efinition", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "gt",
    utils.cmd("Telescope lsp_type_definitions"),
    { desc = "Goto (T)ype definitions...", buffer = bufnr }
  )

  vim.keymap.set(
    "n",
    "gD",
    vim.diagnostic.open_float,
    { desc = "Show (D)iagnostic", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "]d",
    vim.diagnostic.goto_next,
    { desc = "Next (D)iagnostic", buffer = bufnr }
  )
  vim.keymap.set(
    "n",
    "[d",
    vim.diagnostic.goto_prev,
    { desc = "Previous (D)iagnostic", buffer = bufnr }
  )

  vim.keymap.set(
    "n",
    "<Leader>sl",
    utils.cmd("LspInfo"),
    { desc = "LSP: Info", buffer = bufnr }
  )
end

return M
