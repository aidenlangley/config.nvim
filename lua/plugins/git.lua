---@type utils
local utils = require("utils")

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost" },
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
        utils.cmd("Gitsigns stage_hunk"),
        mode = "v",
        desc = "(S)tage hunk",
      },
      {
        "<Leader>gr",
        utils.cmd("Gitsigns reset_hunk"),
        mode = "v",
        desc = "(R)eset hunk",
      },
    },
    opts = {
      current_line_blame = true,
      current_line_blame_formatter = "<author> (<author_time:%Y-%m-%d>): <summary>",
      current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 500,
      },
      preview_config = { border = "none" },
    },
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
        utils.cmd("DiffviewOpen"),
        desc = "(D)iff",
      },
      {
        "<Leader>gd",
        utils.cmd("DiffviewFileHistory"),
        desc = "(H)istory",
      },
    },
    config = true,
  },
}
