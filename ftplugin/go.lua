local null_ls = require("null-ls")
local utils = require("utils")

utils.register_null_ls_sources({
  null_ls.builtins.formatting.gofumpt,
  null_ls.builtins.formatting.golines.with({
    extra_args = { "-m", "80", "-t", "2", "--base-formatter", "gofumpt" },
  }),
})
