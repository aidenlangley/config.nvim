return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "debugloop/telescope-undo.nvim",
    },
    cmd = { "Telescope" },
    keys = {
      {
        "<C-f>",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "(F)uzzy find...",
      },
      {
        "<Leader><Space>",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers...",
      },
      {
        "t:",
        function()
          require("telescope.builtin").command_history()
        end,
        desc = "Command History...",
      },
      {
        "ta",
        function()
          require("telescope.builtin").autocommands()
        end,
        desc = "(A)utocommands...",
      },
      {
        "tC",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "(C)ommands...",
      },
      {
        "td",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "(D)iagnostics...",
      },
      {
        "tf",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "(F)ind files...",
      },
      {
        "tg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live (G)rep...",
      },
      {
        "th",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "(H)elp...",
      },

      {
        "tm",
        function()
          require("telescope.builtin").marks()
        end,
        desc = "(M)arks...",
      },
      {
        "tp",
        function()
          require("telescope").extensions.projects.projects()
        end,
        desc = "(P)rojects...",
      },
      {
        "tr",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "(R)ecent files...",
      },
      {
        "tk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "(K)eymaps...",
      },
      {
        "tt",
        function()
          require("telescope.builtin").builtin()
        end,
        desc = "Buil(t)ins...",
      },
      {
        "tu",
        function()
          require("telescope").extensions.undo.undo()
        end,
        desc = "(U)ndo history...",
      },
      {
        "<Leader>gB",
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = "(B)ranches...",
      },
      {
        "<Leader>gc",
        function()
          require("telescope.builtin").git_commits()
        end,
        desc = "(C)ommits...",
      },
      {
        "<Leader>gt",
        function()
          require("telescope.builtin").git_status()
        end,
        desc = "(S)tatus...",
      },
      {
        "<Leader>gT",
        function()
          require("telescope.builtin").git_stash()
        end,
        desc = "S(t)ash...",
      },
      {
        "<Leader>sf",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Plugins: (F)ind...",
      },
      {
        "<Leader>sg",
        function()
          require("telescope.builtin").live_grep({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Plugins: (G)rep...",
      },
      {
        "<Leader>rr",
        function()
          require("telescope.builtin").reloader()
        end,
        desc = "(R)eload...",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          path_display = { "smart" },
          dynamic_preview_title = true,
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
              ["<C-n>"] = nil,
              ["<C-p>"] = nil,
            },
          },
        },
        pickers = {
          buffers = { theme = "dropdown" },
          current_buffer_fuzzy_find = { theme = "dropdown" },
          diagnostics = { theme = "ivy" },
          find_files = { theme = "dropdown" },
          git_branches = { theme = "dropdown" },
          git_commits = { theme = "dropdown" },
          git_status = { theme = "dropdown" },
          grep_string = { theme = "dropdown" },
          live_grep = { theme = "dropdown" },
          lsp_definitions = { theme = "dropdown" },
          lsp_implementations = { theme = "dropdown" },
          lsp_references = { theme = "dropdown" },
          lsp_type_definitions = { theme = "dropdown" },
          oldfiles = { theme = "dropdown" },
        },
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.7,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      ---@type table
      local ts = require("telescope")
      ts.setup(opts)

      pcall(ts.load_extension, "fzf")
      pcall(ts.load_extension, "notify")
      pcall(ts.load_extension, "projects")
      pcall(ts.load_extension, "refactoring")
      pcall(ts.load_extension, "undo")
    end,
  },
}
