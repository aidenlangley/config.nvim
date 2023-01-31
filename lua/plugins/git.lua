---@module 'utils'
---@type Util
local Util = require("utils")

return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "]h",
        function()
          require("gitsigns").next_hunk()
        end,
        desc = "Next (h)unk",
      },
      {
        "[h",
        function()
          require("gitsigns").prev_hunk()
        end,
        desc = "Previous (h)unk",
      },
      {
        "<Leader>gb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "(B)lame",
      },
      {
        "<Leader>gD",
        function()
          require("gitsigns").toggle_deleted()
        end,
        desc = "Toggle (D)eleted",
      },
      {
        "<Leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "(P)review hunk",
      },
      {
        "<Leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "(R)eset buffer",
      },
      {
        "<Leader>gS",
        function()
          require("gitsigns").stage_buffer()
        end,
        desc = "(S)tage buffer",
      },
      {
        "<Leader>gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "(U)ndo stage",
      },
      {
        "<Leader>gs",
        Util.cmd("Gitsigns stage_hunk"),
        mode = "v",
        desc = "(S)tage hunk",
      },
      {
        "<Leader>gr",
        Util.cmd("Gitsigns reset_hunk"),
        mode = "v",
        desc = "(R)eset hunk",
      },
    },
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
    },
    keys = {
      {
        "<Leader>gd",
        Util.cmd("DiffviewOpen"),
        desc = "(D)iff",
      },
      {
        "<Leader>gd",
        Util.cmd("DiffviewFileHistory"),
        desc = "(H)istory",
      },
    },
    config = true,
  },
}
