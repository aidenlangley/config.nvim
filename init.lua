-- vim options
require("config.options")

-- Set up dashboard - once Lazy is finished, it'll finish it up.
require("dashboard").setup()

-- Starts dashboard when Lazy has started.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  once = true,
  callback = function()
    -- Checks that a file wasn't passed as an argument to nvim
    if vim.fn.argc() == 0 or #vim.v.argv == 0 then
      require("alpha").start(false)

      -- Dashboard loads after nvim has created an empty buffer, because we're
      -- waiting for LazyVimStarted to fire. Just delete the redundant buffer.
      vim.api.nvim_buf_delete(1, {})
    end
  end,
})

-- Package manager
-- https://github.com/folke/lazy.nvim
require("config.lazy")

-- Our keymaps & autocommands
require("config.keymaps")
require("config.autocmds")

-- Final steps
vim.g.neo_tree_remove_legacy_commands = 1
