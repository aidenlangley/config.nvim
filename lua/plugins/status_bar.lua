return {
  "feline-nvim/feline.nvim",
  event = { "VeryLazy" },
  config = function()
    local bg_lighter = "#3c3836"

    local mode_provider = {
      provider = "vi_mode",
      icon = "",
      hl = function()
        return {
          ---@type string
          name = require("feline.providers.vi_mode").get_mode_highlight_name(),
          bg = bg_lighter,
          ---@type string
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
      hl = { bg = "gray" },
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
      hl = { bg = bg_lighter },
      left_sep = "block",
    }

    local attached_clients_provider = {
      provider = function()
        ---@type table<integer, string>
        local clients = {}

        ---@type table
        local active_clients = vim.lsp.get_active_clients({
          bufnr = vim.api.nvim_get_current_buf(),
        })

        ---@param client table
        for _, client in ipairs(active_clients) do
          -- When handling null-ls clients, we have to further inspect the sources
          if client.name == "null-ls" then
            local avail_sources =
              require("null-ls.sources").get_available(vim.bo.filetype)

            ---@param source table
            for _, source in ipairs(avail_sources) do
              clients[#clients + 1] = source.name
            end
          else
            clients[#clients + 1] = client.name
          end
        end

        ---@type table<string, boolean>
        -- Removing duplicates from clients table
        -- Add duplicated values here, we check against this as we loop through
        -- `clients`.
        local duplicates = {}

        ---@type string[]
        -- Resulting table with duplicates removed
        local squashed = {}

        for _, v in ipairs(clients) do
          if not duplicates[v] then
            squashed[#squashed + 1] = v
            duplicates[v] = true
          end
        end

        return table.concat(squashed, " "), " "
      end,
      hl = { fg = "gray" },
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
      hl = { bg = bg_lighter },
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
      hl = { fg = "gray" },
    }

    require("feline").setup({
      components = {
        active = {
          -- LEFT
          {
            mode_provider,
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
      vi_mode_colors = {
        NORMAL = "#ebdbb2",
        OP = "#fb4934",
        COMMAND = "#fb4934",
        INSERT = "#b8bb26",
        VISUAL = "#83a598",
        TERM = "#fabd2f",
      },
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
