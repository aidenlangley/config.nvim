return function(_, bufnr)
  vim.keymap.set(
    'n',
    '<Leader>f',
    vim.lsp.buf.format,
    { desc = 'Format', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    '<F2>',
    vim.lsp.buf.rename,
    { desc = 'Rename', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    'K',
    vim.lsp.buf.hover,
    { desc = 'Hover', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    'gs',
    vim.lsp.buf.signature_help,
    { desc = '+goto signature help', buffer = bufnr }
  )

  vim.keymap.set(
    'n',
    'gdg',
    vim.lsp.buf.definition,
    { desc = '+goto Definition', buffer = bufnr }
  )

  vim.keymap.set('n', 'gi', function()
    require('telescope.builtin').lsp_implementations()
  end, { desc = '+goto implementations...', buffer = bufnr })

  vim.keymap.set('n', 'gr', function()
    require('telescope.builtin').lsp_references()
  end, { desc = '+goto references...', buffer = bufnr })

  vim.keymap.set('n', 'gt', function()
    require('telescope.builtin').lsp_type_definitions()
  end, { desc = '+goto type definitions...', buffer = bufnr })
end