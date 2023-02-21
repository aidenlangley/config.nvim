return {
  {
    "echasnovski/mini.ai",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    event = { "BufReadPre" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          a = ai.gen_spec.treesitter({
            a = "@parameter.outer",
            i = "@parameter.inner",
          }, {}),
          b = ai.gen_spec.treesitter({
            a = "@block.outer",
            i = "@block.inner",
          }, {}),
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }, {}),
          d = ai.gen_spec.treesitter({
            a = "@comment.outer",
            i = "@comment.inner",
          }, {}),
          f = ai.gen_spec.treesitter({
            a = { "@function.outer", "@method.outer" },
            i = { "@function.inner", "@method.inner" },
          }, {}),
          g = ai.gen_spec.treesitter({
            a = "@call.outer",
            i = "@call.inner",
          }, {}),
          l = ai.gen_spec.treesitter({
            a = "@loop.outer",
            i = "@loop.inner",
          }, {}),
          o = ai.gen_spec.treesitter({
            a = "@conditional.outer",
            i = "@conditional.inner",
          }, {}),
          -- Whole buffer
          G = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "echasnovski/mini.align",
    keys = { "ga", "gA" },
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },
  {
    "echasnovski/mini.animate",
    event = { "BufAdd" },
    enabled = true,
    opts = function()
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

      return {
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
      }
    end,
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },
  {
    "echasnovski/mini.basics",
    enabled = false,
  },
  {
    "echasnovski/mini.base16",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      palette = {
        base00 = "#1d2021",
        base01 = "#3c3836",
        base02 = "#504945",
        base03 = "#665c54",
        base04 = "#bdae93",
        base05 = "#d5c4a1",
        base06 = "#ebdbb2",
        base07 = "#fbf1c7",
        base08 = "#fb4934",
        base09 = "#fe8019",
        base0A = "#fabd2f",
        base0B = "#b8bb26",
        base0C = "#8ec07c",
        base0D = "#83a598",
        base0E = "#d3869b",
        base0F = "#d65d0e",
      },
      use_cterm = true,
    },
    config = function(_, opts)
      require("mini.base16").setup(opts)
    end,
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<Leader>d",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "(D)elete buffer",
        noremap = true,
      },
    },
  },
  {
    "echasnovski/mini.comment",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    event = { "BufReadPost" },
    opts = {
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        textobject = "gc",
      },
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  {
    "echasnovski/mini.cursorword",
    event = { "BufAdd" },
    config = function()
      require("mini.cursorword").setup({})
    end,
  },
  {
    "echasnovski/mini.doc",
    enabled = false,
    event = { "VeryLazy" },
    config = function()
      require("mini.doc").setup({})
    end,
  },
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },
  {
    "echasnovski/mini.map",
    enabled = false,
    event = { "BufAdd" },
    opts = function()
      local map = require("mini.map")
      return {
        integrations = {
          map.gen_integration.diagnostic(),
          map.gen_integration.gitsigns(),
        },
      }
    end,
    config = function(_, opts)
      require("mini.map").setup(opts)
      -- vim.api.nvim_create_autocmd("BufReadPost", {
      --   group = vim.api.nvim_create_augroup("MiniMapOpen", { clear = true }),
      -- })
    end,
  },
  {
    "echasnovski/mini.move",
    enabled = false,
    config = function()
      require("mini.move").setup({})
    end,
  },
  {
    "echasnovski/mini.sessions",
    enabled = false,
    config = function(_, opts)
      require("mini.sessions").setup(opts)
    end,
  },
  {
    "echasnovski/mini.starter",
    dependencies = { "echasnovski/mini.sessions" },
    event = "UIEnter",
    opts = function()
      local title = table.concat({
        [[                   |         |         ]],
        [[  __ \    _ \   _` |   _ \   __|   __| ]],
        [[  |   |   __/  (   |  (   |  |   \__ \ ]],
        [[ _|  _| \___| \__,_| \___/  \__| ____/ ]],
      }, "\n")

      local function stats_str(stats)
        return string.format(
          "💤 %s/%s plugins loaded in %sms  ",
          stats.loaded,
          stats.count,
          math.floor(stats.startuptime * 100 + 0.5) / 100,
          stats.real_cputime
        )
      end

      local starter = require("mini.starter")
      return {
        evaluate_single = true,
        header = function()
          return string.format("%s\n\n%s", title, stats_str(require("lazy").stats()))
        end,
        items = {
          { name = "Home", action = "Lazy", section = "Lazy" },
          { name = "Sync", action = "Lazy sync", section = "Lazy" },
          { name = "Update", action = "Lazy update", section = "Lazy" },
          { name = "Profile", action = "Lazy profile", section = "Lazy" },
          { name = "Log", action = "Lazy log", section = "Lazy" },
          { name = "Clean", action = "Lazy clean", section = "Lazy" },
          -- Sometimes we want to update LSP clients
          { name = "Mason", action = "Mason", section = "Plugins" },
          -- Find & grep plugin files for debugging / being nosy
          {
            name = "Find plugin files...",
            action = function()
              require("telescope.builtin").find_files({
                cwd = require("lazy.core.config").options.root,
              })
            end,
            section = "Plugins",
          },
          {
            name = "Grep plugins...",
            action = function()
              require("telescope.builtin").live_grep({
                cwd = require("lazy.core.config").options.root,
              })
            end,
            section = "Plugins",
          },
          {
            name = "Recent Projects...",
            action = "Telescope projects",
            section = "Plugins",
          },
          starter.sections.recent_files(9),
          { name = "New", action = "enew", section = "Actions" },
          { name = "Settings", action = "e ~/.config/nvim/init.lua", section = "Actions" },
          { name = "Quit", action = "qa!", section = "Actions" },
        },
        footer = "",
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing("all", { "Lazy", "Plugins", "Actions" }),
          starter.gen_hook.aligning("center", "center"),
        },
      }
    end,
    config = function(_, opts)
      -- Lazy is installing missing plugins for us, so we'll come back later
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStartedOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("mini.starter").setup(opts)

      vim.keymap.set("n", "<Leader>;", function()
        require("mini.starter").open()
      end, { desc = "Dashboard" })
    end,
  },
  {
    "echasnovski/mini.surround",
    keys = {
      { "ys", mode = { "n", "v", "o" } },
      { "ds", mode = { "n", "v", "o" } },
      { "cs", mode = { "n", "v", "o" } },
      { "yss", mode = "n" },
    },
    opts = {
      mappings = {
        add = "ys", -- ysiw( will surround a word with brackets
        delete = "ds", -- ds( will delete the brackets
        find = "",
        find_left = "",
        highlight = "",
        replace = "cs", -- cs([ will turn brackets to square brackets
        update_n_lines = "",
        suffix_last = "",
        suffix_next = "",
      },
      custom_surroundings = {
        -- There are spaces within the brackets by default - this removes
        -- them.
        ["("] = { output = { left = "(", right = ")" } },
        [")"] = { output = { left = "(", right = ")" } },
        ["["] = { output = { left = "[", right = "]" } },
        ["]"] = { output = { left = "[", right = "]" } },
        ["{"] = { output = { left = "{", right = "}" } },
        ["}"] = { output = { left = "{", right = "}" } },
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
      vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })
    end,
  },
  {
    "echasnovski/mini.tabline",
    event = { "VeryLazy" },
    config = function()
      require("mini.tabline").setup({})
    end,
  },
}
