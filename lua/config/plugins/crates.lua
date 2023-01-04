local M = {
  "saecki/crates.nvim",
  event = "BufRead Cargo.toml",
  enabled = false,

  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  require("crates").setup({ curl_args = { "-sL", "--retry", "4" } })
end

return M
