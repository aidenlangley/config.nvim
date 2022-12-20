return {
	"ahmedkhalf/project.nvim", -- Detects projects
	"danymat/neogen", -- Generates documentation
	"echasnovski/mini.nvim", -- Simple buffer line & more
	"elihunter173/dirbuf.nvim", -- File structure editor
	"feline-nvim/feline.nvim", -- Status bar
	"folke/todo-comments.nvim", -- Highlights TODO, NOTE, etc. comments
	"folke/which-key.nvim", -- Display keybindings
	"ggandor/leap.nvim", -- King of movement plugins
	"goolord/alpha-nvim", -- Dashboard
	"lukas-reineke/indent-blankline.nvim", -- Add indentation guides even on blank lines
	"mcauley-penney/tidy.nvim", -- Trims trailing whitespace & lines with an autocmd
	"norcalli/nvim-colorizer.lua", -- Highlights colours
	"stevearc/dressing.nvim", -- Styles popups

	{ -- File/buffer explorer
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = "MunifTanjim/nui.nvim",
	},

	-- Git related plugins
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
}
