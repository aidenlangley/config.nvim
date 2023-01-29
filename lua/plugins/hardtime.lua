local M = {
  "takac/vim-hardtime",
  event = { "BufWinEnter" },
  cmd = { "HardTimeOn", "HardTimeOff", "HardTimeToggle" },
  enabled = false,
}

function M.init()
  vim.g.hardtime_default_on = 1
end

function M.config()
  -- Allowed to type again after this many milliseconds
  vim.g.hardtime_timeout = 1000

  -- With this on, you are allowed to press jl, for example, without interference
  vim.g.hardtime_allow_different_key = true

  -- This is the maximum amount of hjkl keystrokes allowed
  vim.g.hardtime_maxcount = 1

  -- If 5j is pressed after j, the number of allowed keystrokes resets to 0
  vim.g.hardtime_motion_with_count_resets = 1

  -- Disable hardtime in these buffers
  vim.g.hardtime_ignore_buffer_patterns = { "Telescope" }
end

return M
