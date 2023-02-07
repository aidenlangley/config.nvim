return {
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle" },
    keys = {
      {
        "<Leader>T",
        require("utils").cmd("TSPlaygroundToggle"),
        desc = "Treesitter: Playground",
      },
    },
  },
  {
    "mfussenegger/nvim-treehopper",
    keys = { { "m", mode = { "x", "o" } } },
    config = function()
      vim.cmd([[
        omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
        xnoremap <silent> m :lua require('tsht').nodes()<CR>
      ]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    keys = {
      -- "<Leader>lp",
      "]",
      "[",
      ">",
      "<",
      { ";", mode = "v" },
      { ",", mode = "v" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "bash",
          "comment",
          "css",
          "diff",
          "fish",
          "gitignore",
          "go",
          "help",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "rust",
          "svelte",
          "sql",
          "toml",
          "typescript",
          "vim",
          "vue",
          "yaml",
        },

        -- Plugins
        autotag = { enable = true },
        context_commentstring = { enable = true },
        highlight = {
          enable = true,
          disable = {
            "txt",
            "vue",
          },
        },
        indent = { enable = true },
        matchup = { enable = true },
        playground = { enable = true },
        textobjects = {
          lsp_interop = {
            enable = false,
            border = "none",
            peek_definition_code = {
              ["<Leader>lp"] = { query = { "@function.*", "@class.*" } },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]c"] = { "@class.outer", "@method.outer" },
              ["]f"] = "@function.outer",
              ["]z"] = { query = "@fold", query_group = "folds" },
            },
            goto_next_end = {
              ["]C"] = { "@class.outer", "@method.outer" },
              ["]F"] = "@function.outer",
              ["]Z"] = { query = "@fold", query_group = "folds" },
            },
            goto_previous_start = {
              ["[c"] = { "@class.outer", "@method.outer" },
              ["[f"] = "@function.outer",
              ["[z"] = { query = "@fold", query_group = "folds" },
            },
            goto_previous_end = {
              ["[C"] = { "@class.outer", "@method.outer" },
              ["[F"] = "@function.outer",
              ["[Z"] = { query = "@fold", query_group = "folds" },
            },
            goto_next = {
              ["]g"] = "@call.outer",
              ["]p"] = "@paramater.outer",
            },
            goto_previous = {
              ["[g"] = "@call.outer",
              ["[p"] = "@paramater.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              [">p"] = "@parameter.inner",
            },
            swap_previous = {
              ["<p"] = "@parameter.inner",
            },
          },
        },
        textsubjects = {
          enable = true,
          prev_selection = ",", -- (Optional) keymap to select the previous selection
          keymaps = {
            ["."] = "textsubjects-smart",
          },
        },
      })
    end,
  },
}
