local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },

  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}

function M.config()
  local actions = require("telescope.actions")
  local mappings = {
    i = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    },
    n = {
      ["<C-n>"] = nil,
      ["<C-p>"] = nil,
    },
  }

  local pickers = {
    -- buffers = { theme = "ivy" },
    builtin = { theme = "dropdown" },
    -- command_history = { theme = "dropdown" },
    current_buffer_fuzzy_find = { theme = "dropdown" },
    diagnostics = { theme = "ivy" },
    find_files = { theme = "dropdown" },
    git_branches = { theme = "ivy" },
    git_commits = { theme = "ivy" },
    git_status = { theme = "ivy" },
    grep_string = { theme = "dropdown" },
    -- keymaps = { theme = "dropdown" },
    -- help_tags = { theme = "dropdown" },
    live_grep = { theme = "dropdown" },
    lsp_definitions = { theme = "ivy" },
    lsp_implementations = { theme = "ivy" },
    lsp_references = { theme = "ivy" },
    lsp_type_definitions = { theme = "ivy" },
    -- marks = { theme = "dropdown" },
    oldfiles = { theme = "dropdown" },
  }

  local ts = require("telescope")
  ts.setup({
    defaults = { mappings = mappings },
    pickers = pickers,
  })

  pcall(ts.load_extension, "fzf")
  pcall(ts.load_extension, "notify")
  pcall(ts.load_extension, "projects")
  pcall(ts.load_extension, "refactoring")
end

return M
