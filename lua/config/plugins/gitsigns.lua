local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

function M.config()
  local gs = require("gitsigns")
  gs.setup()

  local function nmap(keys, func, desc)
    if desc then
      desc = "Git: " .. desc
    end

    vim.keymap.set("n", keys, func, { desc = desc })
  end

  nmap("]c", gs.next_hunk, "Next hunk")
  nmap("[c", gs.prev_hunk, "Previous hunk")

  local utils = require("utils")
  local wk = require("which-key")

  wk.register({
    b = {
      function()
        gs.blame_line({ full = true })
      end,
      "[B]lame",
    },
    D = { gs.toggle_deleted, "Toggle [D]eleted" },
    p = { gs.preview_hunk, "[P]review" },
    R = { gs.reset_buffer, "[R]eset" },
    S = { gs.stage_buffer, "[S]tage" },
    u = { gs.undo_stage_hunk, "[U]ndo stage" },
  }, { prefix = "<Leader>g" })

  wk.register({
    g = {
      name = "[G]it...",
      s = { utils.cmd("Gitsigns stage_hunk"), "[S]tage" },
      r = { utils.cmd("Gitsigns reset_hunk"), "[R]eset" },
    },
  }, { prefix = "<Leader>", mode = "v" })
end

return M
