local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufWinEnter",
}

local function get_desc(desc)
  if desc then
    return "Git: " .. (desc or "?")
  end
end

local function nmap(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = get_desc(desc) })
end

local function vmap(keys, func, desc)
  vim.keymap.set("v", keys, func, { desc = get_desc(desc) })
end

function M.config()
  local gs = require("gitsigns")
  gs.setup()

  nmap("]c", gs.next_hunk, "Next hunk")
  nmap("[c", gs.prev_hunk, "Previous hunk")

  nmap("<Leader>gb", function()
    gs.blame_line({ full = true })
  end, "[B]lame")

  nmap("<Leader>gD", gs.toggle_deleted, "Toggle [D]eleted")
  nmap("<Leader>gp", gs.preview_hunk, "[P]review hunk")
  nmap("<Leader>gR", gs.reset_buffer, "[R]eset buffer")
  nmap("<Leader>gS", gs.stage_buffer, "[S]tage buffer")
  nmap("<Leader>gu", gs.undo_stage_hunk, "[U]ndo stage")

  local utils = require("utils")
  vmap("<Leader>gs", utils.cmd("Gitsigns stage_hunk"), "[S]tage")
  vmap("<Leader>gr", utils.cmd("Gitsigns reset_hunk"), "[R]eset")
end

return M
