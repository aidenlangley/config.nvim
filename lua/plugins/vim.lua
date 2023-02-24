return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
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
  "tpope/vim-sensible", -- Sensible options.
  "tpope/vim-repeat", -- Make more actions `.` repeatable.
  "tpope/vim-sleuth", -- Detect indentation automatically.
  -- "tpope/vim-vinegar", -- File explorer?
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_motion_enabled = 0
      vim.g.matchup_surround_enabled = 0
      vim.g.matchup_text_obj_linewise_operators = {}
      vim.g.matchup_transmute_enabled = 0

      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_hi_surround_always = 1
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
  {
    "mg979/vim-visual-multi",
    enabled = false,
    keys = {
      "<C-n>", -- Selects word incrementally
      "<C-N>", -- Selects all words
      "<C-Down>",
      "<C-Left>",
      "<C-Right>",
      "<C-Up>",
    },
    config = function()
      vim.g.multi_cursor_start_word_key = "<C-n>"
      vim.g.multi_cursor_select_all_word_key = "<C-N>"
      vim.g.multi_cursor_start_key = "g<C-n>"
      vim.g.multi_cursor_select_all_key = "g<C-N>"
      vim.g.multi_cursor_next_key = "<C-n>"
      vim.g.multi_cursor_prev_key = "<C-p>"
      vim.g.multi_cursor_skip_key = "<C-x>"
      vim.g.multi_cursor_quit_key = "<Esc>"
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  { "fladson/vim-kitty", ft = "kitty" },
}
