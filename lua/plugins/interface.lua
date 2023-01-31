return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  {
    "goolord/alpha-nvim",
    dependencies = { "ahmedkhalf/project.nvim" },
    event = "UIEnter",
    keys = {
      {
        "<Leader>;",
        require("utils").cmd("Alpha"),
        desc = "Dashboard",
      },
    },
    opts = {
      layout = {},
      opts = {
        margin = 12,
      },
    },
    config = function(_, opts)
      -- Lazy is installing missing plugins for us, so we'll come back later
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      ---@module 'utils'
      ---@type Util
      local Util = require("utils")

      ---@module 'dashboard'
      ---@type Dashboard
      local dashboard = require("dashboard")

      ---@type { }
      local layout = dashboard.layout
      local button = dashboard.button

      local stats = require("lazy").stats()
      ---@type string
      layout[4].val = "  "
        .. stats.loaded
        .. "/"
        .. stats.count
        .. " plugins, "
        .. (math.floor(stats.startuptime * 100 + 0.5) / 100)
        .. "ms  "

      ---@module 'project_nvim'
      ---@type string[]
      local rp = require("project_nvim").get_recent_projects()

      -- Reverse recent projects
      for i = 1, math.floor(#rp / 2) do
        rp[i], rp[#rp - i + 1] = rp[#rp - i + 1], rp[i]
      end

      for _, project_path in ipairs(rp) do
        local index = #layout[16].val + 1

        -- Only print 9 most recent projects
        if index >= 11 then
          break
        end

        local cmd = Util.cmd("e " .. project_path .. "<Bar>Telescope find_files")
        local project_name = vim.fn.fnamemodify(project_path, ":t")
        local short_project_path = vim.fn.fnamemodify(project_path, ":~")
        local text = " " .. project_name .. " (" .. short_project_path .. ")"

        ---@type DashboardItem
        layout[16].val[index] = button(tostring(index - 1), cmd, text)
      end

      ---@param filename string
      for _, filename in ipairs(vim.v.oldfiles) do
        local index = #layout[20].val + 1

        ---@module 'utils'
        ---@type string
        local cmd = require("utils").cmd("e " .. filename)
        if vim.fn.filereadable(filename) == 1 then
          local short_filename = vim.fn.fnamemodify(filename, ":~"):sub(1, 64)

          ---@type DashboardItem
          layout[20].val[index] = button(tostring((index + 10) - 1), cmd, " " .. short_filename)
        end
      end

      opts.layout = layout
      require("alpha").setup(opts)
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
    event = "BufReadPre",
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
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        marks = false,
        registers = false,
        presets = {
          g = true,
          nav = true,
          operators = false,
          text_objects = true,
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
        { l = { name = "(L)SP..." } },
        { o = { name = "(O)pen..." } },
        { r = { name = "(R)e(name/factor/load)..." } },
        { s = { name = "(S)ettings..." } },
      }, {
        prefix = "<Leader>",
        mode = { "n", "v" },
      })
      wk.register({
        { ["ds"] = { name = "(D)elete (S)urround" } },
        { ["ys"] = { name = "(S)urround" } },
        { ["cs"] = { name = "(C)hange (S)urround" } },
      }, {
        mode = { "n", "v", "o" },
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
      local colours = require("config.colours").THEME
      return {
        handle = { color = colours.grey },
        marks = {
          Search = { color = colours.yellow },
          Error = { color = colours.red },
          Warn = { color = colours.orange },
          Info = { color = colours["light-grey"] },
          Hint = { color = colours.fg },
          Misc = { color = colours.cyan },
        },
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
        desc = "Zoom",
      },
    },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = true
      require("windows").setup({})
    end,
  },
  {
    "folke/drop.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      math.randomseed(os.time())
      local theme = ({ "stars", "snow" })[math.random(2, 3)]
      require("drop").setup({ theme = theme })
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    enabled = false,
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
