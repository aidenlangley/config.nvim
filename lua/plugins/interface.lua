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
      local utils = require("utils")
      local dashboard = require("dashboard")
      local layout = dashboard.layout
      local button = dashboard.button

      local stats = require("lazy").stats()
      layout[4].val = "  "
        .. stats.loaded
        .. "/"
        .. stats.count
        .. " plugins, "
        .. (math.floor(stats.startuptime * 100 + 0.5) / 100)
        .. "ms  "

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

        local cmd = utils.cmd("e " .. project_path .. "<Bar>Telescope find_files")
        local project_name = vim.fn.fnamemodify(project_path, ":t")
        local short_project_path = vim.fn.fnamemodify(project_path, ":~")
        local text = " " .. project_name .. " (" .. short_project_path .. ")"
        layout[16].val[index] = button(tostring(index - 1), cmd, text)
      end

      ---@diagnostic disable-next-line: undefined-field
      for _, filename in ipairs(vim.v.oldfiles) do
        local index = #layout[20].val + 1
        local cmd = require("utils").cmd("e " .. filename)
        if vim.fn.filereadable(filename) == 1 then
          local short_filename = vim.fn.fnamemodify(filename, ":~"):sub(1, 64)
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
    config = true,
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
    config = function()
      local is_not_single_window = function(win_id)
        local tabpage_id = vim.api.nvim_win_get_tabpage(win_id)
        return #vim.api.nvim_tabpage_list_wins(tabpage_id) > 1
      end

      local animate = require("mini.animate")
      animate.setup({
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
    branch = "v2.x",
    cmd = { "Neotree" },
    keys = {
      {
        "<C-e>",
        require("utils").cmd("Neotree toggle"),
        desc = "Explorer",
        noremap = true,
      },
    },
    opts = {
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
          operators = true,
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
    end,
  },
  {
    "rcarriga/nvim-notify",
    init = function()
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
    opts = { excluded_filestypes = { "neo-tree" } },
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
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      --
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPost",
    opts = {
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local icon, color = require("nvim-web-devicons").get_icon_color(filename)
        return {
          { icon, guifg = color },
          { " " },
          { filename },
        }
      end,
    },
  },
  {
    "folke/drop.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      math.randomseed(os.time())
      local theme = ({ "stars", "snow" })[math.random(1, 3)]
      require("drop").setup({ theme = theme })
    end,
  },
}
