local null_ls = require("null-ls")
local utils = require("utils")

utils.register_null_ls_sources({
  null_ls.builtins.formatting.prettierd.with({
    filetypes = { "markdown" },
  }),
})
