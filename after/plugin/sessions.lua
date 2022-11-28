require("auto-session").setup({
	log_level = "error",
	auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
	auto_session_enable_last_session = true,
})
require("session-lens").setup({})
require("telescope").load_extension("session-lens")
