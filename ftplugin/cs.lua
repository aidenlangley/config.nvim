local null_ls = require("null-ls")
local utils = require("utils")

utils.register_null_ls_sources({
  null_ls.builtins.formatting.csharpier,
})

-- Indent by this many spaces
vim.opt_local.shiftwidth = 4
