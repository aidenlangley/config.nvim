vim.opt.spell = true
vim.opt.spelllang = 'uk,en'
vim.opt.spelloptions = 'camel'
vim.opt.complete:append('kspell')

-- Autocommand for managing spell file when manual edits are made
-- TODO
-- vim.api.nvim_create_autocmd('', opts?)
-- ':runtime spell/cleanadd.vim<CR>'