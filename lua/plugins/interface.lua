return {
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_transparent_bg = "1"
      vim.g.gruvbox_contrast_dark = "hard"
      vim.g.gruvbox_invert_selection = "0"
      vim.g.gruvbox_sign_column = "bg0"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost" },
    opts = {
      char = "│",
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
    keys = {
      {
        "<C-e>",
        require("utils").cmd("Neotree toggle"),
        desc = "Explorer (NeoTree)",
        noremap = true,
      },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      -- Opening a directory will load neo-tree.
      -- hijack_netrw_behavior = "open_default" does the rest.
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(tostring(vim.fn.argv(0)))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      close_if_last_window = true,
      enable_diagnostics = true,
      enable_git_status = true,
      hide_root_node = true,
      use_popups_for_input = true,
      window = {
        position = "left",
        width = 28,
        mappings = {
          ["<Space>"] = "none",
          ["d"] = function(state)
            ---@type table
            local tree = state.tree
            ---@type table
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
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          visible = true,
          show_hidden_count = false,
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    keys = { "<C-w>", "<Leader>", "g", "t", "z" },
    opts = {
      plugins = {
        marks = false,
        presets = {
          g = true,
          nav = false,
          operators = false,
          text_objects = false,
          windows = true,
          z = true,
        },
        registers = false,
        spelling = false,
      },
      disable = {
        filetypes = {
          "neo-tree",
          "TelescopePrompt",
        },
      },
      key_labels = {
        ["<Leader>"] = "SPC",
        ["<space>"] = "SPC",
        ["<Space>"] = "SPC",
        ["<C-Space>"] = "C-SPC",
        ["<CR>"] = "CR",
        ["<Tab>"] = "TAB",
        ["<S-Tab>"] = "S-TAB",
        ["<BS>"] = "<-",
      },
      show_help = false,
      show_keys = false,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.register({ t = { name = "(T)elescope..." } })
      wk.register({
        { c = { name = "(C)omment..." } },
        { g = { name = "(G)it..." } },
        { o = { name = "(O)pen..." } },
        { r = { name = "(R)e(name/factor/load)..." } },
        { s = { name = "(S)ettings..." } },
      }, {
        prefix = "<Leader>",
        mode = { "n", "v" },
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    init = function()
      vim.notify = require("notify")
    end,
    opts = {
      max_height = function()
        return math.floor(vim.o.lines * 0.6)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = { "BufAdd" },
    opts = {
      excluded_filestypes = {
        "prompt",
        "TelescopePrompt",
        "neo-tree",
        "notify",
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    cmd = { "ZenMode" },
    keys = {
      {
        "<S-z>",
        require("utils").cmd("ZenMode"),
        desc = "ZenMode",
      },
    },
    opts = { plugins = { gitsigns = true } },
  },
  {
    "stevearc/dressing.nvim",
    event = { "BufReadPost" },
    config = true,
  },
  {
    "b0o/incline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufAdd" },
    opts = {
      render = function(props)
        local filename =
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        ---@type string, string
        local icon, color =
          require("nvim-web-devicons").get_icon_color(filename)
        return {
          {
            icon,
            guifg = color, ---@type string
          },
          { " " },
          { filename },
        }
      end,
    },
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass" },
    event = { "BufAdd" },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = true
      require("windows").setup({})
    end,
  },
  {
    "folke/noice.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
    },
    event = { "VeryLazy" },
    opts = {
      messages = {
        view = "mini",
        view_error = "mini",
        view_warning = "mini",
      },
      commands = { last = { view = "mini" } },
      lsp = {
        progress = {
          enabled = false,
          throttle = 512,
          view = "mini",
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },
}
