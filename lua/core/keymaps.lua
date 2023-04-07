local utils = require("utils")

-- Open `~/.config/nvim/init.lua`
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
vim.keymap.set(
  "n",
  "<C-.>",
  vim.lsp.buf.code_action,
  { desc = "Code actions..." }
)

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
local move_lines_desc = "Move line down"
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { desc = move_lines_desc })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = move_lines_desc })
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi", { desc = move_lines_desc })

move_lines_desc = "Move line up"
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { desc = move_lines_desc })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = move_lines_desc })
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi", { desc = move_lines_desc })

-- Telescope
local ts_keymaps = {
  {
    "<Leader><Space>",
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Buffers...",
  },
  {
    "t:",
    function()
      require("telescope.builtin").command_history()
    end,
    desc = "Command History...",
  },
  {
    "ta",
    function()
      require("telescope.builtin").autocommands()
    end,
    desc = "(A)utocommands...",
  },
  {
    "tC",
    function()
      require("telescope.builtin").commands()
    end,
    desc = "(C)ommands...",
  },
  {
    "td",
    function()
      require("telescope.builtin").diagnostics()
    end,
    desc = "(D)iagnostics...",
  },
  {
    "tf",
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "(F)ind files...",
  },
  {
    "th",
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "(H)elp...",
  },

  {
    "tm",
    function()
      require("telescope.builtin").marks()
    end,
    desc = "(M)arks...",
  },
  {
    "tp",
    utils.cmd("Telescope projects"),
    desc = "(P)rojects...",
  },
  {
    "tr",
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "(R)ecent files...",
  },
  {
    "tk",
    function()
      require("telescope.builtin").keymaps()
    end,
    desc = "(K)eymaps...",
  },
  {
    "tt",
    function()
      require("telescope.builtin").builtin()
    end,
    desc = "Buil(t)ins...",
  },
  {
    "<Leader>sf",
    function()
      require("telescope.builtin").find_files({
        cwd = require("lazy.core.config").options.root,
      })
    end,
    desc = "Plugins: (F)ind...",
  },
}

for _, keymap in ipairs(ts_keymaps) do
  vim.keymap.set(
    keymap.mode or "n",
    keymap[1],
    keymap[2],
    { desc = keymap.desc or string.format("Telescope%n", #ts_keymaps + 1) }
  )
end

-- Go back to the dashboard
vim.keymap.set("n", "<Leader>;", function()
  require("mini.starter").open()
end, { desc = "Dashboard" })
