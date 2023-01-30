return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "RRethy/nvim-treesitter-textsubjects",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  event = "BufReadPre",
  keys = {
    {
      "<Leader>T",
      require("utils").cmd("TSPlaygroundToggle"),
      desc = "Treesitter Playground",
    },
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
      indent = { enable = false },
      playground = { enable = true },
      textobjects = {
        lsp_interop = {
          enable = true,
          border = "none",
          peek_definition_code = {
            ["<Leader>lp"] = "@function.outer",
            ["<Leader>lP"] = "@class.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["]p"] = "@parameter.inner",
          },
          swap_previous = {
            ["[p"] = "@parameter.inner",
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
}
