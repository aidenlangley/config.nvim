local M = {
  "ThePrimeagen/refactoring.nvim",
  event = "BufWinEnter",
  enabled = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

local function get_desc(desc)
  if desc then
    return "Refactoring: " .. (desc or "?")
  end
end

local function nmap(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = get_desc(desc) })
end

local function vmap(keys, func, desc)
  vim.keymap.set("v", keys, func, { desc = get_desc(desc) })
end

function M.config()
  local rf = require("refactoring")
  rf.setup()

  local utils = require("utils")
  nmap(
    "<Leader>rb",
    utils.cmd([[lua require("refactoring").refactor("Extract Block")]]),
    "Extract [B]lock"
  )
  nmap(
    "<Leader>rB",
    utils.cmd([[lua require("refactoring").refactor("Extract Block To File")]]),
    "Extract [B]lock to file"
  )
  nmap(
    "<Leader>rv",
    utils.cmd([[lua require("refactoring").refactor("Inline Variable")]]),
    "Inline [V]ariable"
  )

  vmap(
    "<Leader>rf",
    [[<ESC><CMD>lua require("refactoring").refactor("Extract Function")<CR>]],
    "Extract [F]unction"
  )
  vmap(
    "<Leader>rF",
    [[<ESC><CMD>lua require("refactoring").refactor("Extract Function To File")<CR>]],
    "Extract [F]unction to file"
  )
  vmap(
    "<Leader>ri",
    [[<ESC><CMD>lua require("refactoring").refactor("Inline Variable")<CR>]],
    "[I]nline Variable"
  )
  vmap(
    "<Leader>rv",
    [[<ESC><CMD>lua require("refactoring").refactor("Extract Variable")<CR>]],
    "[E]xtract Variable"
  )

  require("which-key").register(
    { r = { name = "[R]efactor..." } },
    { prefix = "<Leader>", mode = { "n", "v" } }
  )
end

return M
