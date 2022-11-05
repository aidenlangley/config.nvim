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
})

-- Reload plugin specifications
packer.reset()

-- Register plugins, avoid configuring plugins here
packer.use({
	"wbthomason/packer.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"jghauser/mkdir.nvim",
	-- UI:
	"sainnhe/gruvbox-material",
	"Yazeed1s/minimal.nvim",
	"folke/which-key.nvim",
	"lukas-reineke/indent-blankline.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/trouble.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("trouble").setup({})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
	},
	-- Notifications
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	config = function()
	-- 		local notify = require("notify")
	-- 		notify.setup({
	-- 			icons = {
	-- 				ERROR = "✗",
	-- 				INFO = "כֿ",
	-- 				WARN = "",
	-- 			},
	-- 			min_width = 24,
	-- 			max_width = 48,
	-- 		})
	-- 		vim.notify = notify
	-- 		require("telescope").load_extension("notify")
	-- 	end,
	-- },
	-- Status line:
	"feline-nvim/feline.nvim",
	-- Terminal:
	{
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				autochdir = false,
				direction = "float",
				open_mapping = "<C-t>",
			})
		end,
	},
	-- Dashboard:
	{
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	-- File explorer:
	{
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require("nvim-tree").setup({
				view = {
					adaptive_size = true,
					side = "right",
				},
				renderer = {
					icons = {
						git_placement = "after",
					},
				},
			})
		end,
	},
	-- LSP:
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"jose-elias-alvarez/null-ls.nvim",
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({})
		end,
	},
	-- Debugging:
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	-- Treesitter:
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({
				with_sync = true,
			})
		end,
	},
	"JoosepAlviste/nvim-ts-context-commentstring",
	"simrat39/symbols-outline.nvim",
	-- Completions:
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-emoji",
	"chrisgrieser/cmp-nerdfont",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"onsails/lspkind.nvim",
	{ "L3MON4D3/LuaSnip", tag = "v1.1.*" },
	"hrsh7th/nvim-cmp",
	-- mini:
	{
		"echasnovski/mini.nvim",
		branch = "stable",
		config = function()
			require("mini.align").setup({})
			require("mini.bufremove").setup({})
			require("mini.comment").setup({})
			require("mini.cursorword").setup({})
			require("mini.pairs").setup({})
			require("mini.surround").setup({})
			require("mini.tabline").setup({})
		end,
	},
	-- File management:
	"elihunter173/dirbuf.nvim",
	-- Languages/syntax:
	"b0o/schemastore.nvim",
	"simrat39/rust-tools.nvim",
	"fladson/vim-kitty",
	-- Formatting
	{
		"mcauley-penney/tidy.nvim",
		config = function()
			require("tidy").setup({
				filetype_exclude = { "markdown", "diff" },
			})
		end,
	},
	-- Projects/Sessions
	{
		"ahmedkhalf/project.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("project_nvim").setup({
				show_hidden = true,
				silent_chdir = false,
				patterns = {
					".git",
					".gitignore",
					".luacheckrc",
					"cargo.toml",
					"Makefile",
					"package.json",
				},
			})
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		module = "persistence",
		config = function()
			require("persistence").setup()
		end,
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
		tag = "release",
		config = function()
			require("gitsigns").setup({})
		end,
	},
})

-- Now sync plugins - packer has been installed, so packer_bootstrap will
-- return true when called a second time.
if packer_bootstrap then
	require("packer").sync()
end
