-- Install packer
local install_path = vim.fn.stdpath("data")
  .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute(
    "!git clone https://github.com/wbthomason/packer.nvim " .. install_path
  )
  vim.cmd([[packadd packer.nvim]])
end

local packer = require("packer")
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
})

-- Use core plugins
packer.use("wbthomason/packer.nvim")
packer.use(require("core.plugins"))

-- If we've defined some extra plugins, use them too. These are superfluous, so
-- we're okay with passing on them if they are unavailable for w/e reason.
local has_plugins, plugins = pcall(require, "extra.plugins")
if has_plugins then
  packer.use(plugins)
end

if is_bootstrap then
  require("packer").sync()
end

local nmap = function(keys, func, desc)
  if desc then
    desc = "Packer: " .. desc
  end

  vim.keymap.set("n", keys, func, { desc = desc, silent = true })
end

-- Set up some keybindings.
nmap("<Leader>ps", "<CMD>PackerStatus<CR>", "Status")
nmap("<Leader>pS", "<CMD>PackerSync<CR>", "Sync")
nmap("<Leader>pi", "<CMD>PackerInstall<CR>", "Install")
nmap("<Leader>pc", "<CMD>PackerCompile<CR>", "Compile")
nmap("<Leader>pC", "<CMD>PackerClean<CR>", "Clean")

return is_bootstrap
