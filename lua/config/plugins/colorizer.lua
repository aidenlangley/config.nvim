local M = {
  "norcalli/nvim-colorizer.lua",
  event = "BufReadPre",
}

function M.config()
  require("colorizer").setup({
    ["*"] = {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      mode = "background",
    },
  })
end

return M
