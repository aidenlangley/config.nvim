local M = {
  "feline-nvim/feline.nvim",
}

function M.config()
  local feline = require("feline")

  local THEME = require("config.colours").THEME
  local MODES = {
    NORMAL = "fg",
    OP = "red",
    COMMAND = "red",
    INSERT = "green",
    VISUAL = "blue",
    TERM = "yellow",
  }

  local function get_sep(str, fg, bg)
    local sep = { str = str }
    sep["hl"] = {}
    sep.hl["bg"] = bg
    sep.hl["fg"] = fg

    return sep
  end

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
    priority = 1,
  }

  local file_encoding_provider = {
    enabled = function()
      return require("feline.providers.file").file_encoding() ~= "UTF-8"
    end,
    provider = "file_encoding",
    left_sep = "block",
    priority = 2,
  }

  local file_type_provider = {
    provider = {
      name = "file_type",
      opts = {
        filetype_icon = true,
        case = "lowercase",
      },
    },
    hl = { fg = "green" },
    left_sep = "block",
    priority = 2,
  }

  local file_info_provider = {
    provider = {
      name = "file_info",
      opts = { type = "unique-short" },
    },
    hl = { fg = "light-grey" },
    left_sep = "block",
    icon = "",
    priority = 3,
  }

  local attached_clients_provider = {
    provider = "lsp_client_names",
    hl = { fg = "light-grey" },
    icon = "",
    left_sep = "block",
    update = { "FileType" },
    priority = 1,
  }

  local scroll_bar_provider = {
    provider = "scroll_bar",
    hl = { fg = "cyan" },
    priority = 1,
  }

  local position_provider = {
    provider = {
      name = "position",
      opts = { format = "{col}" },
    },
    hl = { bg = "grey" },
    left_sep = "block",
    right_sep = "block",
    priority = 1,
  }

  local git_branch_provider = {
    provider = "git_branch",
    right_sep = "block",
    left_sep = "block",
    priority = 3,
  }

  local git_diff_added_provider = {
    provider = "git_diff_added",
    priority = 3,
    hl = { fg = "green" },
  }

  local git_diff_removed_provider = {
    provider = "git_diff_removed",
    priority = 3,
    hl = { fg = "red" },
  }

  local git_diff_changed_provider = {
    provider = "git_diff_changed",
    priority = 3,
    hl = { fg = "yellow" },
  }

  local diag_errors_provider = {
    provider = "diagnostic_errors",
    hl = { fg = "red" },
    priority = 2,
  }

  local diag_warnings_provider = {
    provider = "diagnostic_warnings",
    hl = { fg = "yellow" },
    priority = 2,
  }

  local diag_hints_provider = {
    provider = "diagnostic_hints",
    priority = 2,
  }

  local diag_info_provider = {
    provider = "diagnostic_info",
    hl = { fg = "light-grey" },
    priority = 2,
  }

  feline.setup({
    components = {
      active = {
        -- LEFT
        {
          mode_provider,
          file_encoding_provider,
          file_type_provider,
          -- file_info_provider,
          attached_clients_provider,
        },
        -- MIDDLE
        {},
        -- RIGHT
        {
          diag_info_provider,
          diag_hints_provider,
          diag_warnings_provider,
          diag_errors_provider,
          git_diff_changed_provider,
          git_diff_removed_provider,
          git_diff_added_provider,
          git_branch_provider,
          position_provider,
          scroll_bar_provider,
        },
      },
      inactive = {
        -- LEFT
        {
          file_info_provider,
        },
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
end

return M