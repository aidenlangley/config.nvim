local function get_desc(desc)
  return "Telescope: " .. (desc or "?")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = { "Telescope" },
    keys = {
      {
        "<C-f>",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = get_desc("(F)uzzy find..."),
      },
      {
        "<Leader><Space>",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = get_desc("Buffers..."),
      },
      {
        "ta",
        function()
          require("telescope.builtin").autocommands()
        end,
        desc = get_desc("(A)utocommands..."),
      },
      {
        "tC",
        function()
          require("telescope.builtin").commands()
        end,
        desc = get_desc("(C)ommands..."),
      },
      {
        "td",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = get_desc("(D)iagnostics..."),
      },
      {
        "tf",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = get_desc("(F)ind files..."),
      },
      {
        "tg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = get_desc("Live (G)rep..."),
      },
      {
        "th",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = get_desc("(H)elp..."),
      },
      {
        "tH",
        function()
          require("telescope.builtin").command_history()
        end,
        desc = get_desc("Command (H)istory..."),
      },
      {
        "tm",
        function()
          require("telescope.builtin").marks()
        end,
        desc = get_desc("(M)arks..."),
      },
      {
        "tp",
        function()
          require("telescope").extensions.projects.projects()
        end,
        desc = get_desc("(P)rojects..."),
      },
      {
        "tr",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = get_desc("(R)ecent files..."),
      },
      {
        "tk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = get_desc("(K)eymaps..."),
      },
      {
        "tt",
        function()
          require("telescope.builtin").builtin()
        end,
        desc = get_desc("(B)uiltins..."),
      },
      {
        "tb",
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = get_desc("Git (B)ranches..."),
      },
      {
        "tc",
        function()
          require("telescope.builtin").git_commits()
        end,
        desc = get_desc("Git (C)ommits..."),
      },
      {
        "ts",
        function()
          require("telescope.builtin").git_status()
        end,
        desc = get_desc("Git (S)tatus..."),
      },
      {
        "tS",
        function()
          require("telescope.builtin").git_stash()
        end,
        desc = get_desc("Git (S)tash..."),
      },
      {
        "<Leader>ld",
        function()
          require("telescope.builtin").lsp_definitions()
        end,
        desc = "LSP: View (D)efinitions...",
      },
      {
        "<Leader>li",
        function()
          require("telescope.builtin").lsp_implementations()
        end,
        desc = "LSP: View (I)mplementations...",
      },
      {
        "<Leader>lr",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "LSP: View (R)eferences...",
      },
      {
        "<Leader>lt",
        function()
          require("telescope.builtin").lsp_type_definitions()
        end,
        desc = "LSP: View (T)ype definitions...",
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
        desc = get_desc("(R)eload..."),
      },
    },
    config = function()
      local actions = require("telescope.actions")
      local mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<C-n>"] = nil,
          ["<C-p>"] = nil,
        },
      }

      local pickers = {
        buffers = { theme = "dropdown" },
        -- builtin = { theme = "ivy" },
        -- command_history = { theme = "dropdown" },
        current_buffer_fuzzy_find = { theme = "dropdown" },
        diagnostics = { theme = "ivy" },
        find_files = { theme = "dropdown" },
        git_branches = { theme = "dropdown" },
        git_commits = { theme = "dropdown" },
        git_status = { theme = "dropdown" },
        grep_string = { theme = "dropdown" },
        -- keymaps = { theme = "ivy" },
        -- help_tags = { theme = "dropdown" },
        live_grep = { theme = "dropdown" },
        lsp_definitions = { theme = "dropdown" },
        lsp_implementations = { theme = "dropdown" },
        lsp_references = { theme = "dropdown" },
        lsp_type_definitions = { theme = "dropdown" },
        -- marks = { theme = "dropdown" },
        oldfiles = { theme = "dropdown" },
      }

      local ts = require("telescope")
      ts.setup({
        defaults = { mappings = mappings },
        pickers = pickers,
      })

      pcall(ts.load_extension, "fzf")
      pcall(ts.load_extension, "notify")
      pcall(ts.load_extension, "projects")
      pcall(ts.load_extension, "refactoring")
    end,
  },
}
