local M = {
  "folke/trouble.nvim",
  cmd = { "Trouble", "TroubleToggle" },
}

function M.config()
  local trouble = require("trouble")
  trouble.setup()

  local function nmap(keys, func, desc)
    if desc then
      desc = "Trouble: " .. desc
    end

    vim.keymap.set("n", keys, func, { desc = desc })
  end

  local opts = { skip_groups = true, jump = true }
  nmap("]t", function()
    trouble.next(opts)
  end, "Next")
  nmap("[t", function()
    trouble.previous(opts)
  end, "Previous")
end

return M
