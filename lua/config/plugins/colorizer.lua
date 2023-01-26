local M = {
  "norcalli/nvim-colorizer.lua",
  event = "BufReadPre",
}

function M.config()
  local web_dev_config = {
    RGB = false,
    RRGGBB = false,
    RRGGBBAA = false,
    names = true,
    rgb_fn = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
    mode = "background",
  }

  require("colorizer").setup({
    css = web_dev_config,
    html = web_dev_config,
    javascript = web_dev_config,
    svelte = web_dev_config,
    typescript = web_dev_config,
    vue = web_dev_config,
    ["*"] = {
      RGB = true,
      RRGGBB = true,
      RRGGBBAA = true,
      mode = "background",
    },

    "!neo-tree",
    "!Telescope",
  })
end

return M
