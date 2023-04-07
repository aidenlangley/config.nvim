---@alias LspClientKeymaps fun(client: LspClient, bufnr: number): nil
---@type LspClientKeymaps
return function(_, bufnr)
  ---@param desc string
  ---@return table | nil
  local function keymap_options(desc)
    return {
      desc = desc,
      buffer = bufnr,
      remap = true,
    }
  end

  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, keymap_options("LSP: Rename"))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_options("LSP: Hover"))
  vim.keymap.set(
    "n",
    "gs",
    vim.lsp.buf.signature_help,
    keymap_options("LSP: (S)ignature help")
  )

  vim.keymap.set(
    "n",
    "gi",
    vim.lsp.buf.implementation,
    keymap_options("LSP: Goto (I)mplementations...")
  )
  vim.keymap.set(
    "n",
    "gr",
    vim.lsp.buf.references,
    keymap_options("LSP: Goto (R)eferences...")
  )
  vim.keymap.set(
    "n",
    "gd",
    vim.lsp.buf.definition,
    keymap_options("LSP: Goto (D)efinition")
  )
  vim.keymap.set(
    "n",
    "gt",
    vim.lsp.buf.type_definition,
    keymap_options("LSP: Goto (T)ype definitions...")
  )

  vim.keymap.set(
    "n",
    "gD",
    vim.diagnostic.open_float,
    keymap_options("(D)iagnostic: Open float")
  )
  vim.keymap.set(
    "n",
    "]d",
    vim.diagnostic.goto_next,
    keymap_options("(D)iagnostic: Goto next")
  )
  vim.keymap.set(
    "n",
    "[d",
    vim.diagnostic.goto_prev,
    keymap_options("(D)iagnostic: Goto previous")
  )
end
