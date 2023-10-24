return function(_, bufnr)
  vim.keymap.set(
    'n',
    '<Leader>f',
    vim.lsp.buf.format,
    { desc = 'Format', buffer = bufnr }
  )

  local ok, _ = pcall(require, 'inc_rename')
  if ok then
    vim.keymap.set('n', '<F2>', function()
      return ':IncRename ' .. vim.fn.expand('<cword>')
    end, { desc = 'Rename', buffer = bufnr, expr = true })
  else
    vim.keymap.set(
      'n',
      '<F2>',
      vim.lsp.buf.rename,
      { desc = 'Rename', buffer = bufnr }
    )
  end

  vim.keymap.set(
    'n',
    'K',
    vim.lsp.buf.hover,
    { desc = 'Hover doc', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    'gs',
    vim.lsp.buf.signature_help,
    { desc = 'Goto signature help', buffer = bufnr }
  )
  vim.keymap.set(
    'n',
    'gdd',
    vim.lsp.buf.definition,
    { desc = 'Goto definition', buffer = bufnr }
  )
  vim.keymap.set('n', 'gi', function()
    require('telescope.builtin').lsp_implementations()
  end, { desc = 'Goto implementation', buffer = bufnr })

  vim.keymap.set('n', 'gr', function()
    require('telescope.builtin').lsp_references()
  end, { desc = 'Goto reference', buffer = bufnr })

  vim.keymap.set('n', 'gt', function()
    require('telescope.builtin').lsp_type_definitions()
  end, { desc = 'Goto type definitions...', buffer = bufnr })
end
