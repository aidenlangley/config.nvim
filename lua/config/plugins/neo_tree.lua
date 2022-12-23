local M = {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VimEnter",

  branch = "v2.x",
  dependencies = { "MunifTanjim/nui.nvim" },
}

function M.config()
  vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])

  local config = {
    close_if_last_window = true,
    enable_diagnostics = true,
    enable_git_status = true,
    hide_root_node = true,
    use_popups_for_input = false,
    window = {
      position = "left",
      width = 28,
    },
    source_selector = {
      statusline = true,
      tab_labels = {
        filesystem = " dir",
        buffers = " buf",
        git_status = " git",
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          added = "",
          modified = "",
          deleted = "✖",
          renamed = "R",
          untracked = "?",
          ignored = "I",
          unstaged = "U",
          staged = "S",
          conflict = "",
        },
      },
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = false,
      hijack_netrw_behavior = "disabled",
      filtered_items = {
        visible = true,
        show_hidden_count = false,
      },
    },
  }

  require("neo-tree").setup(config)
end

return M
