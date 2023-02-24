local null_ls = require("null-ls")
local utils = require("utils")

utils.register_null_ls_sources({
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.selene.with({
    args = { "-q", "--allow-warnings", "-" },
    condition = function(nls_utils)
      return nls_utils.root_has_file({ "selene.toml" })
    end,
  }),
})

-- Create custom surrouding for Lua's block string `[[...]]`. Use this inside
-- autocommand or 'after/ftplugin/lua.lua' file.
vim.b.minisurround_config = {
  custom_surroundings = {
    s = {
      input = { "%[%[().-()%]%]" },
      output = { left = "[[", right = "]]" },
    },
  },
}

vim.b.miniai_config = {
  custom_textobjects = {
    s = { "%[%[().-()%]%]" },
  },
}
