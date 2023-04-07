local M = {}

---@param specs string | string[] | table[]
---@param opts table | boolean | nil
function M.setup(specs, opts)
  -- Clones `lazy` if not present already
  require("core.lazy.bootstrap")

  -- Merge our configs, preferring `opts` passed to this function
  local options = require("core.lazy.options")
  if type(opts) == "table" then
    vim.tbl_deep_extend("force", options, opts)
  elseif opts == false then
    -- If we've explicitly made `opts` `false` we'll make sure we use lazy
    -- defaults by setting it to an empty table.
    options = {}
  end

  -- To keep things simple we're just going to rename this back to `opts`.
  opts = options

  -- `specs` can be a table in a couple of different forms:
  -- { "core.plugins", "code.plugins" }
  --
  -- Or:
  -- {
  --   { import = "core.dashboard" },
  --   { import = "core.lsp" },
  -- }
  --
  -- Or a single Lua module: `"core"`.
  if type(specs) == "table" then
    opts["spec"] = specs
    require("lazy").setup(opts)
  else
    require("lazy").setup(specs, opts)
  end

  -- Sets up keymaps related to `lazy`
  require("core.lazy.keymaps")
end

return M
