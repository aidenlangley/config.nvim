return {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			"j-hui/fidget.nvim",
		},
	},

	{ -- Completions
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
		},
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},
	{ -- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	},
	"windwp/nvim-ts-autotag", -- Treesitter plugin to automatically close HTML tags & the like

	-- Provides alternative formatting, linting & code actions
	"jose-elias-alvarez/null-ls.nvim",

	"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
	"nvim-tree/nvim-web-devicons", -- Icons
	"onsails/lspkind.nvim", -- Assists in formatting completion menu items
	"sainnhe/gruvbox-material", -- Best theme
	"windwp/nvim-autopairs", -- Assists with pairs of ({[]})

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" },
	},

	{ -- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available.
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		cond = vim.fn.executable("make") == 1,
	},
}
