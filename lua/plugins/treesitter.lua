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
    event = { "BufReadPre" },
    opts = {
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
        "json5",
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
        "tsx",
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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = "<Nop>",
          node_decremental = "<BS>",
        },
      },
      indent = {
        enable = true,
        disable = {
          "fish",
          "svelte",
        },
      },
      matchup = { enable = false },
      playground = { enable = false },
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
          set_jumps = false,
          goto_next_start = {
            ["]c"] = "@class.outer",
            ["]f"] = "@function.outer",
            ["]z"] = {
              query = "@fold",
              query_group = "folds",
              desc = "Next fold start",
            },
          },
          goto_next_end = {
            ["]C"] = "@class.outer",
            ["]F"] = "@function.outer",
            ["]Z"] = {
              query = "@fold",
              query_group = "folds",
              desc = "Next fold end",
            },
          },
          goto_previous_start = {
            ["[c"] = "@class.outer",
            ["[f"] = "@function.outer",
            ["[z"] = {
              query = "@fold",
              query_group = "folds",
              desc = "Next fold start",
            },
          },
          goto_previous_end = {
            ["[C"] = "@class.outer",
            ["[F"] = "@function.outer",
            ["[Z"] = {
              query = "@fold",
              query_group = "folds",
              desc = "Next fold end",
            },
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
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      local ts_repeat_move =
        require("nvim-treesitter.textobjects.repeatable_move")
      vim.keymap.set(
        { "n", "x", "o" },
        ";",
        ts_repeat_move.repeat_last_move_next
      )
      vim.keymap.set(
        { "n", "x", "o" },
        ",",
        ts_repeat_move.repeat_last_move_previous
      )
    end,
  },
}
