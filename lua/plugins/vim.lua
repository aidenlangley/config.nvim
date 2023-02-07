return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "Gedit",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GRename",
      "GDelete",
      "GRemove",
      "GBrowse",
      "Gsplit",
    },
  },
  "tpope/vim-surround",
  -- "tpope/vim-commentary",
  "tpope/vim-sensible",
  {
    "andymass/vim-matchup",
    event = "BufReadPre",
    config = function()
      vim.g.matchup_motion_enabled = 0
      vim.g.matchup_surround_enabled = 0
      vim.g.matchup_text_obj_linewise_operators = {}
      vim.g.matchup_transmute_enabled = 0

      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_hi_surround_always = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }

      local colours = require("config.colours").THEME
      vim.api.nvim_set_hl(0, "MatchParenCur", {
        fg = colours.grey,
        bg = colours.bg,
      })
    end,
  },
  {
    "mg979/vim-visual-multi",
    keys = {
      "<C-n>", -- Selects word incrementally
      "<M-n>", -- Selects all words
      "<C-Down>",
      "<C-Left>",
      "<C-Right>",
      "<C-Up>",
    },
    config = function()
      vim.g.multi_cursor_start_word_key = "<C-n>"
      vim.g.multi_cursor_select_all_word_key = "<M-n>"
      vim.g.multi_cursor_start_key = "g<C-n>"
      vim.g.multi_cursor_select_all_key = "g<M-n>"
      vim.g.multi_cursor_next_key = "<C-n>"
      vim.g.multi_cursor_prev_key = "<C-p>"
      vim.g.multi_cursor_skip_key = "<C-x>"
      vim.g.multi_cursor_quit_key = "<Esc>"
    end,
  },
}
