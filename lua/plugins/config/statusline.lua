local feline = require("feline")

-- Gruvbox baby
local THEME = {
	fg = "#ebdbb2",
	bg = "#282828",
	grey = "#504945",
	["light-grey"] = "#89786E",
	skyblue = "#83a598",
	cyan = "#89b482",
	green = "#b8bb26",
	oceanblue = "#076678",
	blue = "#458588",
	magenta = "#d3869b",
	orange = "#d65d0e",
	red = "#ea6962",
	violet = "#b16286",
	yellow = "#fabd2f",
}

local MODES = {
	NORMAL = "fg",
	OP = "red",
	COMMAND = "red",
	INSERT = "green",
	VISUAL = "magenta",
	TERM = "yellow",
}

local function get_sep(str, fg, bg)
	local sep = { str = str }
	if bg or fg then
		sep["hl"] = {}
		if bg then
			sep.hl["bg"] = bg
		end
		if fg then
			sep.hl["fg"] = fg
		end
	end

	return sep
end

local mode_provider = {
	provider = "vi_mode",
	icon = "",
	hl = function()
		return {
			name = require("feline.providers.vi_mode").get_mode_highlight_name(),
			bg = "grey",
			fg = require("feline.providers.vi_mode").get_mode_color(),
			style = "bold",
		}
	end,
	left_sep = "block",
	right_sep = "block",
	priority = 1,
}

local file_encoding_provider = {
	enabled = function()
		return require("feline.providers.file").file_encoding() ~= "UTF-8"
	end,
	provider = "file_encoding",
	left_sep = "block",
	priority = 2,
}

local file_type_provider = {
	provider = {
		name = "file_type",
		opts = {
			filetype_icon = true,
			case = "lowercase",
		},
	},
	hl = { fg = "green" },
	left_sep = "block",
	right_sep = get_sep(": ", "light-grey"),
	priority = 2,
}

local file_info_provider = {
	provider = {
		name = "file_info",
		opts = { type = "unique-short" },
	},
	hl = { fg = "light-grey" },
	icon = "",
	priority = 3,
}

local attached_clients_provider = {
	provider = "lsp_client_names",
	hl = { fg = "grey" },
	left_sep = get_sep(" [", "grey"),
	right_sep = get_sep("] ", "grey"),
	update = { "FileType" },
	priority = 1,
}

local scroll_bar_provider = {
	provider = "scroll_bar",
	hl = { fg = "cyan" },
	priority = 1,
}

local position_provider = {
	provider = {
		name = "position",
		opts = { format = "{col}" },
	},
	hl = { bg = "grey" },
	left_sep = "block",
	right_sep = "block",
	priority = 1,
}

local git_branch_provider = {
	provider = "git_branch",
	right_sep = "block",
	priority = 3,
}

local git_diff_added_provider = {
	provider = "git_diff_added",
	right_sep = "block",
	priority = 3,
}

local git_diff_removed_provider = {
	provider = "git_diff_removed",
	right_sep = "block",
	priority = 3,
}

local git_diff_changed_provider = {
	provider = "git_diff_changed",
	right_sep = "block",
	priority = 3,
}

local diag_errors_provider = {
	provider = "diagnostic_errors",
	hl = { fg = "red" },
	right_sep = "block",
	priority = 2,
}

local diag_warnings_provider = {
	provider = "diagnostic_warnings",
	hl = { fg = "yellow" },
	right_sep = "block",
	priority = 2,
}

local diag_hints_provider = {
	provider = "diagnostic_hints",
	right_sep = "block",
	priority = 2,
}

local diag_info_provider = {
	provider = "diagnostic_info",
	hl = { fg = "light-grey" },
	right_sep = "block",
	priority = 2,
}

feline.setup({
	components = {
		active = {
			-- LEFT:
			{
				mode_provider,
				file_encoding_provider,
				file_type_provider,
				file_info_provider,
				attached_clients_provider,
			},
			-- RIGHT
			{
				diag_info_provider,
				diag_hints_provider,
				diag_warnings_provider,
				diag_errors_provider,
				git_diff_changed_provider,
				git_diff_removed_provider,
				git_diff_added_provider,
				git_branch_provider,
				position_provider,
				scroll_bar_provider,
			},
		},
		inactive = {
			-- LEFT:
			{
				file_info_provider,
			},
			-- RIGHT:
			{},
		},
	},
	theme = THEME,
	vi_mode_colors = MODES,
	disable = {
		filetypes = {
			"^NvimTree$",
			"^Outline$",
			"^Trouble$",
			"^carbon$",
			"^carbon.explorer$",
		},
	},
})
