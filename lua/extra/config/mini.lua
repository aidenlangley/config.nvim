local enable_these = { "cursorword", "tabline" }
for _, module in ipairs(enable_these) do
	require("mini." .. module).setup()
end

-- Due to conflicts with leap, we're changing the prefix 's' to generally be
-- a suffix
local surround_config = {
	mappings = {
		add = "ys", -- ysiw( will surround a word with brackets
		delete = "ds", -- ds( will delete the brackets
		find = "",
		find_left = "",
		highlight = "",
		replace = "cs", -- cs([ will turn brackets to square brackets
		update_n_lines = "",
	},
}

require("mini.surround").setup(surround_config)
