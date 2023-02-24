-- vim options
require("config.options")

-- Starts dashboard when Lazy has started.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  once = true,
  callback = function()
    -- Checks that a file wasn't passed as an argument to nvim
    if vim.fn.argc() == 0 or vim.fn.argv() == 0 then
      require("mini.starter").open(vim.api.nvim_get_current_buf())
    end
  end,
})

-- Package manager
-- https://github.com/folke/lazy.nvim
require("config.lazy")

-- Our keymaps & autocommands
require("config.keymaps")
require("config.autocmds")
