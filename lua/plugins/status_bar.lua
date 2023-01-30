return {
  "feline-nvim/feline.nvim",
  event = "VeryLazy",
  config = function()
    local THEME = require("config.colours").THEME
    local MODES = {
      NORMAL = "fg",
      OP = "red",
      COMMAND = "red",
      INSERT = "green",
      VISUAL = "blue",
      TERM = "yellow",
    }

    local mode_provider = {
      provider = "vi_mode",
      icon = "",
      hl = function()
        return {
          name = require("feline.providers.vi_mode").get_mode_highlight_name(),
          bg = "grey",
          fg = require("feline.providers.vi_mode").get_mode_color(),
          style = "bold",
        }
      end,
      left_sep = "block",
      right_sep = "block",
    }

    local file_encoding_provider = {
      enabled = function()
        return require("feline.providers.file").file_encoding() ~= "UTF-8"
      end,
      provider = "file_encoding",
      hl = { bg = "grey" },
      left_sep = "block",
    }

    local file_type_provider = {
      provider = {
        name = "file_type",
        opts = {
          filetype_icon = true,
          case = "lowercase",
        },
      },
      hl = { bg = "grey" },
      left_sep = "block",
    }

    local attached_clients_provider = {
      provider = function()
        local clients = {}

        for _, client in
          ipairs(vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() }))
        do
          -- When handling null-ls clients, we have to further inspect the sources
          if client.name == "null-ls" then
            for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
              clients[#clients + 1] = source.name
            end
          else
            clients[#clients + 1] = client.name
          end
        end

        return table.concat(clients, " "), " "
      end,
      hl = { fg = "light-grey" },
      left_sep = "block",
      right_sep = "block",
      update = { "FileType" },
      priority = -1,
    }

    local scroll_bar_provider = {
      provider = "scroll_bar",
      hl = { fg = "cyan" },
    }

    local position_provider = {
      provider = {
        name = "position",
        opts = { format = "{col}" },
      },
      hl = { bg = "grey" },
      left_sep = "block",
      right_sep = "block",
    }

    local git_branch_provider = {
      provider = "git_branch",
      right_sep = "block",
      left_sep = "block",
    }

    local git_diff_added_provider = {
      provider = "git_diff_added",
      hl = { fg = "green" },
      icon = {
        str = "+",
        hl = { fg = "green" },
      },
      right_sep = "block",
    }

    local git_diff_removed_provider = {
      provider = "git_diff_removed",
      hl = { fg = "red" },
      icon = {
        str = "-",
        hl = { fg = "red" },
      },
      right_sep = "block",
    }

    local git_diff_changed_provider = {
      provider = "git_diff_changed",
      hl = { fg = "yellow" },
      icon = {
        str = "~",
        hl = { fg = "yellow" },
      },
      right_sep = "block",
    }

    local diag_errors_provider = {
      provider = "diagnostic_errors",
      hl = { fg = "red" },
    }

    local diag_warnings_provider = {
      provider = "diagnostic_warnings",
      hl = { fg = "yellow" },
    }

    local diag_hints_provider = {
      provider = "diagnostic_hints",
    }

    local diag_info_provider = {
      provider = "diagnostic_info",
      hl = { fg = "light-grey" },
    }

    local lazy_provider = {
      provider = function()
        return "💤 " .. require("lazy.status").updates() .. " updates"
      end,
      enabled = require("lazy.status").has_updates,
      hl = { fg = "light-grey" },
      left_sep = "block",
      priority = -1,
    }

    require("feline").setup({
      components = {
        active = {
          -- LEFT
          {
            mode_provider,
            lazy_provider,
            diag_errors_provider,
            diag_warnings_provider,
            diag_hints_provider,
            diag_info_provider,
          },
          -- MIDDLE
          {},
          -- RIGHT
          {
            attached_clients_provider,
            git_branch_provider,
            git_diff_changed_provider,
            git_diff_removed_provider,
            git_diff_added_provider,
            file_encoding_provider,
            file_type_provider,
            position_provider,
            scroll_bar_provider,
          },
        },
        inactive = {
          -- LEFT
          {},
          -- MIDDLE
          {},
          -- RIGHT
          {},
        },
      },
      theme = THEME,
      vi_mode_colors = MODES,
      disable = {
        filetypes = {
          "^NvimTree$",
          "^Outline$",
          "^fugitive$",
          "^fugitiveblame$",
          "^help$",
          "^neo-tree$",
          "^packer$",
          "^qf$",
          "^startify$",
        },
        buftypes = {
          "^terminal$",
        },
      },
    })
  end,
}
