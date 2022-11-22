return {
	-- The package manager manages itself
	"wbthomuson/packer.nvim",
	-- Libraries / utilities
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"jghauser/mkdir.nvim",
	"nathom/filetype.nvim",
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
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	},
	"stevearc/dressing.nvim",
	{
		"j-hui/fidget.nvim",
		event = "BufReadPre",
		config = function()
			require("fidget").setup({})
		end,
	},
	-- Status line:
	"feline-nvim/feline.nvim",
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
	},
	-- Buffers:
	{
		"matbme/JABS.nvim",
		config = function()
			require("jabs").setup({
				position = "center",
				width = 64,
				border = "solid",
				preview = {
					border = "single",
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
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lspsaga").init_lsp_saga({})
		end,
	},
	{
		"folke/trouble.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("trouble").setup({})
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
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"p00f/nvim-ts-rainbow",
	"simrat39/symbols-outline.nvim",
	"mfussenegger/nvim-treehopper",
	{
		"ziontee113/syntax-tree-surfer",
		event = "BufReadPre",
		module = { "syntax-tree-surfer" },
	},
	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				dimming = {
					alpha = 0.5,
				},
				context = 16,
			})
		end,
	},
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
	},
	-- File management:
	"elihunter173/dirbuf.nvim",
	-- Languages/syntax:
	"b0o/schemastore.nvim",
	"simrat39/rust-tools.nvim",
	"fladson/vim-kitty",
	{
		"danymat/neogen",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({
				enabled = true,
			})
		end,
	},
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
	-- Movement
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").set_default_keymaps()
		end,
	},
	-- Terminal
	{
		"numToStr/FTerm.nvim",
		config = function()
			require("FTerm").setup({
				border = "single",
			})
		end,
	},
}
