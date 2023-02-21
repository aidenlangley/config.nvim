local null_ls = require("null-ls")
local utils = require("utils")

utils.register_null_ls_sources({
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.luacheck.with({
    extra_args = { "--config", ".luacheckrc" },
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
