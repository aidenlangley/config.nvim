local utils = require("utils")

vim.keymap.set("n", "<Leader>sL", utils.cmd("Lazy"), { desc = "Open (L)azy" })
vim.keymap.set(
  "n",
  "<Leader>sc",
  utils.cmd("Lazy clean"),
  { desc = "(C)lean plugins" }
)
vim.keymap.set(
  "n",
  "<Leader>sp",
  utils.cmd("Lazy profile"),
  { desc = "(P)rofile plugins" }
)
vim.keymap.set(
  "n",
  "<Leader>ss",
  utils.cmd("Lazy sync"),
  { desc = "(S)ync plugins" }
)
vim.keymap.set(
  "n",
  "<Leader>su",
  utils.cmd("Lazy update"),
  { desc = "(U)pdate plugins" }
)

---@type table<string, fun(plugin: any): nil>
require("core.lazy.options").ui["custom_keys"] = {
  -- Opens `lazygit` in the plugin directory
  ["gg"] = function(plugin)
    require("lazy.util").float_term({ "lazygit", "log" }, { cwd = plugin.dir })
  end,

  -- Opens a blank terminal in the plugin directory
  ["gt"] = function(plugin)
    require("lazy.util").float_term(nil, { cwd = plugin.dir })
  end,

  -- Opens the git repo in a browser
  ["go"] = function(plugin)
    require("lazy.util").open(plugin.url)
  end,
}
