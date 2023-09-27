return function(_, bufnr)
  vim.keymap.set(
    'n',
    '<Leader>f',
    vim.lsp.buf.format,
    { desc = 'LSP: Format', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    '<F2>',
    vim.lsp.buf.rename,
    { desc = 'LSP: Rename', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    'K',
    vim.lsp.buf.hover,
    { desc = 'LSP: Hover', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    'gs',
    vim.lsp.buf.signature_help,
    { desc = 'LSP: Goto signature help', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    'gdd',
    vim.lsp.buf.definition,
    { desc = 'LSP: Goto definition', buffer = bufnr }
  )
  vim.keymap.set('n', 'gi', function()
    require('telescope.builtin').lsp_implementations()
  end, { desc = 'LSP: Goto implementations...', buffer = bufnr })

  vim.keymap.set('n', 'gr', function()
    require('telescope.builtin').lsp_references()
  end, { desc = 'LSP: Goto references...', buffer = bufnr })

  vim.keymap.set('n', 'gt', function()
    require('telescope.builtin').lsp_type_definitions()
  end, { desc = 'Goto type definitions...', buffer = bufnr })
end
