local M = {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = { "Neotree" },

  branch = "v2.x",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  vim.g.neo_tree_remove_legacy_commands = 1

  local config = {
    close_if_last_window = true,
    enable_diagnostics = true,
    enable_git_status = true,
    hide_root_node = true,
    use_popups_for_input = false,
    window = {
      position = "left",
      width = 28,
      mappings = {
        ["d"] = function(state)
          local tree = state.tree
          local node = tree:get_node()
          if node.type == "message" then
            return
          end

          local prompt = string.format("Bin '%s'? (y/N)", node.path)
          local callback = function(input)
            if input == "y" then
              vim.cmd("silent !gio trash " .. node.path)
            end
          end

          vim.ui.input({ prompt = prompt }, callback)
        end,
        ["D"] = "delete",
      },
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
      bind_to_cwd = true,
      follow_current_file = true,
      hijack_netrw_behavior = "disabled",
      filtered_items = {
        visible = true,
        show_hidden_count = false,
      },
    },
  }

  require("neo-tree").setup(config)
end

vim.keymap.set("n", "<C-e>", require("utils").cmd("Neotree toggle"), { desc = "Explorer" })

vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    vim.cmd("Neotree close")
    vim.cmd("wincmd =")
  end,
  group = vim.api.nvim_create_augroup("NeoTree_FocusLost", { clear = true }),
  pattern = "neo-tree *",
})

return M
