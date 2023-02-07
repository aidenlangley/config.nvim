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
        require("utils").cmd("Gitsigns stage_hunk"),
        mode = { "n", "v" },
        desc = "(S)tage hunk",
      },
      {
        "<Leader>gr",
        require("utils").cmd("Gitsigns reset_hunk"),
        mode = { "n", "v" },
        desc = "(R)eset hunk",
      },
    },
    opts = { preview_config = { border = "none" } },
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
        require("utils").cmd("DiffviewOpen"),
        desc = "(D)iff",
      },
      {
        "<Leader>gd",
        require("utils").cmd("DiffviewFileHistory"),
        desc = "(H)istory",
      },
    },
    config = true,
  },
}
