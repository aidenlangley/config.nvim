local node_filter = function(utils)
	return utils.root_has_file({ "node_modules" })
end

return {
	configs = {
		prettier = {
			only_local = "node_modules/.bin",
			condition = node_filter,
		},
		eslint = {
			prefer_local = "node_modules/.bin",
			condition = node_filter,
		},
	},
	diagnostics_format = "[#{c}] #{m} (#{s})",
}
