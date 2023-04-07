return {
  {
    "echasnovski/mini.starter",
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
          math.floor(stats.startuptime * 100) / 100
        )
      end

      return {
        evaluate_single = true,
        header = function()
          return string.format(
            "%s\n\n%s",
            title,
            stats_str(require("lazy").stats())
          )
        end,
        items = {
          { name = "Home", action = "Lazy", section = "Lazy" },
          { name = "Sync", action = "Lazy sync", section = "Lazy" },
          { name = "Update", action = "Lazy update", section = "Lazy" },
          { name = "Profile", action = "Lazy profile", section = "Lazy" },
          { name = "Log", action = "Lazy log", section = "Lazy" },
          { name = "Clean", action = "Lazy clean", section = "Lazy" },
          -- Sometimes we want to update LSP clients
          -- { name = "Mason", action = "Mason", section = "Plugins" },
          -- Find plugin files for debugging / being nosy
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
            name = "Recent Projects...",
            action = "Telescope projects",
            section = "Plugins",
          },
          require("mini.starter").sections.recent_files(9),
          { name = "New", action = "enew", section = "Actions" },
          {
            name = "Settings",
            action = "e ~/.config/nvim/init.lua",
            section = "Actions",
          },
          { name = "Quit", action = "qa!", section = "Actions" },
        },
        footer = "",
        content_hooks = {
          require("mini.starter").gen_hook.adding_bullet(),
          require("mini.starter").gen_hook.indexing(
            "all",
            { "Lazy", "Plugins", "Actions" }
          ),
          require("mini.starter").gen_hook.aligning("center", "center"),
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
    end,
  },
}
