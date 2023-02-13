return {
  {
    "sainnhe/gruvbox-material",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
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
  "nvim-tree/nvim-web-devicons",
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "BufReadPost",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },
  {
    "echasnovski/mini.tabline",
    event = "VeryLazy",
    config = function()
      require("mini.tabline").setup({})
    end,
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    enabled = true,
    config = function()
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set("", key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local is_not_single_window = function(win_id)
        local tabpage_id = vim.api.nvim_win_get_tabpage(win_id)
        return #vim.api.nvim_tabpage_list_wins(tabpage_id) > 1
      end

      ---@module 'mini.animate'
      ---@class MiniAnimate
      ---@field setup fun(config: table)
      ---@field config table
      ---@field gen_timing { linear: fun(opts: table): fun(power: integer, opts: table) }
      ---@field gen_subscroll { equal: fun(opts: table): fun() }
      ---@field gen_winconfig { wipe: fun(opts: table): fun() }
      local animate = require("mini.animate")
      animate.setup({
        scroll = {
          ---@type fun(a, b): integer
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          ---@type fun(total_scroll: integer): boolean
          subscroll = animate.gen_subscroll.equal({
            max_output_steps = 120,
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
        open = {
          winconfig = animate.gen_winconfig.wipe({
            predicate = is_not_single_window,
            direction = "from_edge",
          }),
        },
        close = {
          winconfig = animate.gen_winconfig.wipe({
            predicate = is_not_single_window,
            direction = "to_edge",
          }),
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
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
        hijack_netrw_behavior = "disabled",
        filtered_items = {
          visible = true,
          show_hidden_count = false,
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      plugins = {
        marks = false,
        registers = false,
        presets = {
          g = true,
          nav = false,
          operators = false,
          text_objects = false,
          windows = true,
          z = true,
        },
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
      ---@module 'notify'
      ---@type table
      local notify = require("notify")
      notify.setup({
        max_height = function()
          return math.floor(vim.o.lines * 0.6)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      })

      vim.notify = notify
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = function()
      return {
        excluded_filestypes = {
          "prompt",
          "TelescopePrompt",
          "neo-tree",
          "notify",
        },
      }
    end,
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    cmd = { "ZenMode" },
    keys = {
      {
        "<S-z>",
        require("utils").cmd("ZenMode"),
        { desc = "ZenMode" },
      },
    },
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPost",
    opts = {
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        ---@type string, string
        local icon, color = require("nvim-web-devicons").get_icon_color(filename)
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
    event = "BufReadPost",
    dependencies = { "anuvyklack/middleclass" },
    keys = {
      {
        "<Leader>z",
        require("utils").cmd("WindowsMaximize"),
        desc = "(Z)oom",
      },
    },
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
    event = "VeryLazy",
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
