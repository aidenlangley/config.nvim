local utils = require("utils")

local function get_desc(desc)
  return "Git: " .. (desc or "?")
end

return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "]h",
        function()
          require("gitsigns").next_hunk()
        end,
        desc = get_desc("Next (h)unk"),
      },
      {
        "[h",
        function()
          require("gitsigns").prev_hunk()
        end,
        desc = get_desc("Previous (h)unk"),
      },
      {
        "<Leader>gb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = get_desc("(B)lame"),
      },
      {
        "<Leader>gD",
        function()
          require("gitsigns").toggle_deleted()
        end,
        desc = get_desc("Toggle (D)eleted"),
      },
      {
        "<Leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = get_desc("(P)review hunk"),
      },
      {
        "<Leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = get_desc("(R)eset buffer"),
      },
      {
        "<Leader>gS",
        function()
          require("gitsigns").stage_buffer()
        end,
        desc = get_desc("(S)tage buffer"),
      },
      {
        "<Leader>gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = get_desc("(U)ndo stage"),
      },
      {
        "<Leader>gs",
        utils.cmd("Gitsigns stage_hunk"),
        mode = "v",
        desc = get_desc("(S)tage hunk"),
      },
      {
        "<Leader>gr",
        utils.cmd("Gitsigns reset_hunk"),
        mode = "v",
        desc = get_desc("(R)eset hunk"),
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
        utils.cmd("DiffviewOpen"),
        desc = get_desc("(D)iff"),
      },
      {
        "<Leader>gd",
        utils.cmd("DiffviewFileHistory"),
        desc = get_desc("(H)istory"),
      },
    },
    config = true,
  },
}
