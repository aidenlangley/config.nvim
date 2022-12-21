local tsb = require("telescope.builtin")
local wk = require("which-key")
local utils = require("utils")

local M = {}

function M.settings()
  wk.register({
    s = {
      name = "[S]ettings...",
      l = { utils.cmd("Lazy"), "Lazy" },
      L = { utils.cmd("LspInfo"), "LSP" },
      m = { utils.cmd("Mason"), "Mason" },
      n = { utils.cmd("NullLsInfo"), "NullLs" },
      o = { utils.cmd("e ~/.config/nvim/init.lua"), "Open `init.lua`" },
    },
  }, { prefix = "<Leader>" })
end

function M.buffers()
  wk.register({
    b = {
      name = "[B]uffers...",
      d = { utils.cmd("bd"), "Delete" },
      D = { utils.cmd("%bd|e#|bd#"), "Delete others" },
      n = { utils.cmd("enew"), "New" },
      w = { utils.cmd("w!"), "Write" },
      W = { utils.cmd("wa!"), "Write all" },
    },
  }, { prefix = "<Leader>" })
end

function M.telescope()
  local function nmap(keys, func, desc)
    if desc then
      desc = "Telescope: " .. desc
    end

    vim.keymap.set("n", keys, func, { desc = desc })
  end

  nmap("<C-f>", tsb.current_buffer_fuzzy_find, "Find")
  nmap("<Leader><Space>", tsb.buffers, "Buffers")

  wk.register({
    t = {
      name = "[T]elescope...",
      d = { tsb.diagnostics, "[D]iagnostics" },
      c = { tsb.commands, "[C]ommands" },
      f = { tsb.find_files, "[F]iles" },
      g = { tsb.live_grep, "[G]rep files" },
      h = { tsb.help_tags, "[H]elp" },
      H = { tsb.command_history, "Command [H]istory" },
      k = { tsb.keymaps, "[K]eymaps" },
      m = { tsb.marks, "[M]arks" },
      p = { require("telescope").extensions.projects.projects, "[P]rojects" },
      r = { tsb.recent_files, "[R]ecent files" },
      t = { utils.cmd("Telescope"), "[T]elescope" },
    },
  })
end

function M.git()
  local term_lazygit = utils.float_term("lazygit")
  wk.register({
    g = {
      name = "[G]it...",
      b = { tsb.git_branches, "Branches" },
      C = { tsb.git_commits, "Commits" },
      g = {
        function()
          term_lazygit:toggle()
        end,
        "LazyGit",
      },
      s = { tsb.git_status, "Status" },
      S = { tsb.git_stash, "Stashes" },
    },
  }, { prefix = "<Leader>" })
end

function M.lsp(_, bufnr)
  local function nmap(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<C-.>", vim.lsp.buf.code_action, "Actions")
  nmap("<F2>", vim.lsp.buf.rename, "Rename")
  nmap("K", vim.lsp.buf.hover, "Hover")

  -- Go to...
  wk.register({
    [";"] = { utils.cmd("Alpha"), "Dashboard" },
    c = {
      name = "[C]ode...",
      a = { vim.lsp.buf.code_action, "[A]ctions" },
      f = { "[F]ormat" },
      K = { vim.lsp.buf.hover, "[H]over" },
      s = { vim.lsp.buf.signature_help, "[S]ignature help" },
    },
    l = {
      name = "[L]SP...",
      d = { vim.lsp.buf.definition, "Goto [D]efinition" },
      D = { tsb.lsp_definitions, "View [D]efinitions" },
      i = { vim.lsp.buf.implementation, "Goto [I]mplementation" },
      I = { tsb.lsp_implementations, "View [I]mplementations" },
      r = { tsb.lsp_references, "View [R]eferences" },
      t = { tsb.lsp_type_definitions, "View [T]ype definitions" },
    },
    t = {
      name = "[T]rouble...",
      d = { vim.diagnostic.open_float, "Show [D]iagnostic" },
      n = { vim.diagnostic.goto_next, "[N]ext diagnostic" },
      N = { vim.diagnostic.goto_prev, "Previous diagnostic" },
      t = { utils.cmd("Trouble"), "[T]rouble" },
    },
  }, { prefix = "<Leader>" })

  wk.register({
    f = { "[F]ormat" },
  }, { prefix = "<Leader>c", mode = "v" })

  -- Diagnostics
  nmap("]d", vim.diagnostic.goto_next, "Next diagnostic")
  nmap("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
end

vim.keymap.set("n", "<C-s>", utils.cmd("w"), { desc = "Write buffer" })
vim.keymap.set("n", "<C-h>", utils.cmd("bp"), { desc = "Previous Buffer", silent = true })
vim.keymap.set("n", "<C-l>", utils.cmd("bn"), { desc = "Next Buffer", silent = true })
vim.keymap.set("n", "<C-e>", require("utils").cmd("Neotree toggle"), { desc = "Explorer" })

-- Quit if not modified, else request confirmation
vim.keymap.set("n", "<C-q>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")

  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/N) ",
    }, function(input)
      if input == "y" then
        vim.cmd("q!")
      end
    end)
  else
    vim.cmd("q!")
  end
end, { desc = "Quit" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { desc = "Search forwards", expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { desc = "Search forwards", expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { desc = "Search forwards", expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { desc = "Search backwards", expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { desc = "Search backwards", expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { desc = "Search backwards", expr = true })

-- Move lines
vim.keymap.set("n", "<S-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("i", "<S-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("i", "<S-Up>", "<Esc>:m .-2<CR>==gi", { desc = "move line up" })

M.settings()
M.buffers()
M.telescope()
M.git()

return M
