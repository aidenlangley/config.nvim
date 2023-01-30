local null_ls = require("null-ls")
local utils = require("utils")

utils.register_null_ls_sources({
  null_ls.builtins.formatting.black.with({
    args = { "--line-length", "79" },
  }),
  null_ls.builtins.formatting.isort,
  null_ls.builtins.diagnostics.flake8,
})
