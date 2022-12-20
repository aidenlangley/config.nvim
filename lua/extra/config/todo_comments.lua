local tdc = require("todo-comments")

tdc.setup()

vim.keymap.set("n", "gt", tdc.jump_next, { desc = "Todo: Next [T]odo comment" })
vim.keymap.set("n", "gT", tdc.jump_prev, { desc = "Todo: Prev [T]odo comment" })
