local M = {
  "echasnovski/mini.nvim",
  event = "BufReadPre",

  dependencies = {
    { "JoosepAlviste/nvim-ts-context-commentstring" },
  },
}

local function surround()
  -- Due to conflicts with leap, we're changing the prefix 's' to generally be
  -- a suffix
  local config = {
    mappings = {
      add = "ys", -- ysiw( will surround a word with brackets
      delete = "ds", -- ds( will delete the brackets
      find = "",
      find_left = "",
      highlight = "",
      replace = "cs", -- cs([ will turn brackets to square brackets
      update_n_lines = "",
    },
  }

  require("mini.surround").setup(config)
end

local function comment()
  local config = {
    hooks = {
      pre = function()
        require("ts_context_commentstring.internal").update_commentstring({})
      end,
    },
  }

  require("mini.comment").setup(config)
end

function M.init()
  vim.keymap.set("n", "<C-d>", function()
    require("mini.bufremove").delete(0, false)
  end, { desc = "Delete buffer" })
end

function M.config()
  local enable_these = { "cursorword", "tabline" }
  for _, module in ipairs(enable_these) do
    require("mini." .. module).setup()
  end

  surround()
  comment()
end

return M
