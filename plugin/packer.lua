-- Checks if packer has been installed.
-- If it hasn't, install packer, and return false.
-- If it has, return true.
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

-- If packer has not been installed, it will be installed. Otherwise, this does
-- nothing but return false.
local packer_bootstrap = ensure_packer()

-- Initialise packer with options.
local packer = require("packer")
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
	max_jobs = 4,
})

-- Reload plugin specifications
packer.reset()

-- Register plugins, avoid configuring plugins here
packer.use(require("plugins"))

-- Now sync plugins - packer has been installed, so packer_bootstrap will
-- return true when called a second time.
if packer_bootstrap then
	require("packer").sync()
end
