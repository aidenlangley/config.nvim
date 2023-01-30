return {
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    opts = {
      tools = { hover_actions = { border = "none" } },
      server = {
        on_attach = function(client, bufnr)
          require("lsp").on_attach(client, bufnr)
          require("rust-tools").inlay_hints.enable()
        end,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            inlayHints = { locationLinks = false },
          },
        },
      },
    },
  },
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead Cargo.toml",
    config = true,
  },
}
