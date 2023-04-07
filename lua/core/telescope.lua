return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Telescope" },
    opts = {
      defaults = {
        path_display = { "smart" },
        dynamic_preview_title = true,
      },
      pickers = {
        buffers = { theme = "dropdown" },
        current_buffer_fuzzy_find = { theme = "dropdown" },
        diagnostics = { theme = "ivy" },
        find_files = { theme = "dropdown" },
        lsp_definitions = { theme = "dropdown" },
        lsp_implementations = { theme = "dropdown" },
        lsp_references = { theme = "dropdown" },
        lsp_type_definitions = { theme = "dropdown" },
        oldfiles = { theme = "dropdown" },
      },
    },
  },
}
