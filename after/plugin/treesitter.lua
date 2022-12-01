require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "lua",
    "yaml",
    "toml",
  },
  auto_install = true,
  autopairs = { enable = true },
  autotag = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  endwise = { enable = true },
  highlight = {
    enable = true,
    disable = {
      "txt",
      "vue",
    },
  },
  incremental_selection = { enable = true },
  indent = { enable = false },
  playground = { enable = true },
  rainbow = { enable = false },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = { ["mxp"] = "@parameter.inner" },
      swap_previous = { ["mxP"] = "@parameter.inner" },
    },
    lsp_interop = {
      enable = true,
      border = "none",
      peek_definition_code = {
        ["mpf"] = "@function.outer",
        ["mpc"] = "@class.outer",
      },
    },
  },
})

require("symbols-outline").setup({})
