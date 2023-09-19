require('lspconfig').lua_ls.setup({
  capabilities = require('lsp._capabilities'),
  on_attach = require('lsp._on_attach'),
  single_file_support = true,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      diagnostics = {
        groupSeverity = {
          strong = 'Warning',
          strict = 'Warning',
        },
        groupFileStatus = {
          ['ambiguity'] = 'Opened',
          ['await'] = 'Opened',
          ['codestyle'] = 'None',
          ['duplicate'] = 'Opened',
          ['global'] = 'Opened',
          ['luadoc'] = 'Opened',
          ['redefined'] = 'Opened',
          ['strict'] = 'Opened',
          ['strong'] = 'Opened',
          ['type-check'] = 'Opened',
          ['unbalanced'] = 'Opened',
          ['unused'] = 'Opened',
        },
        unusedLocalExclude = { '_*' },
        libraryFiles = 'Enable',
        workspaceRate = 65,
      },
      completion = {
        workspaceWord = true,
        callSnippet = 'Both',
      },
      hint = {
        enable = true,
        arrayIndex = 'Disable',
        setType = true,
      },
      telemetry = { enable = false },
      misc = { parameters = { '--loglevel=trace' } },
      format = { enable = false },
    },
  },
})