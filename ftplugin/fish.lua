local null_ls = require("null-ls")
local utils = require("utils")

require("cmp").setup.filetype("fish", {
  { name = "fish" },
  ---@diagnostic disable-next-line: redundant-parameter
}, require("completions").sources)

utils.register_null_ls_sources({
  null_ls.builtins.formatting.fish_indent,
  null_ls.builtins.diagnostics.fish,
})

-- Indent by this many spaces
vim.opt_local.shiftwidth = 4
