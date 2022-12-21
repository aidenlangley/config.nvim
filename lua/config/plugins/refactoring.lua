local M = {
  "ThePrimeagen/refactoring.nvim",
}

function M.init()
  local function refactor(op)
    require("refactoring").refactor(op)
  end

  local wk = require("which-key")
  wk.register({ r = { name = "Refactor..." } }, { prefix = "<Leader>c", mode = { "n", "v" } })

  local refactor_prefix = "<Leader>cr"

  -- These don't require visual mode
  wk.register({
    b = {
      function()
        refactor("Extract Block")
      end,
      "Extract [B]lock",
    },
    B = {
      function()
        refactor("Extract Block To File")
      end,
      "Extract [B]lock to file",
    },
    v = {
      function()
        refactor("Inline Variable")
      end,
      "Inline [V]ariable",
    },
  }, { prefix = refactor_prefix })

  -- These do require visual mode
  wk.register({
    f = {
      function()
        refactor("Extract Function")
      end,
      "Extract [F]unction",
    },
    F = {
      function()
        refactor("Extract Function To File")
      end,
      "Extract [F]unction to [F]ile",
    },
    i = {
      function()
        refactor("Inline variable")
      end,
      "[I]nline Variable",
    },
    v = {
      function()
        refactor("Extract Variable")
      end,
      "Extract [V]ariable",
    },
  }, { prefix = refactor_prefix, mode = "v" })
end

function M.config()
  require("refactoring").setup()
end

return M
