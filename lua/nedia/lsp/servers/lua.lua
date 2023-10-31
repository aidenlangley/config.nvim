require('neodev')

return {
  single_file_support = false,
  settings = {
    Lua = {
      -- misc = { parameters = { "--log-level=trace", }, },
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        workspaceWord = true,
        callSnippet = 'Both',
      },
      hover = {
        expandAlias = false,
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = 'Disable',
        semicolon = 'Disable',
        arrayIndex = 'Disable',
      },
      doc = {
        privateName = { '^_' },
      },
      type = {
        castNumberToInteger = true,
      },
      diagnostics = {
        disable = {
          'incomplete-signature-doc',
          'trailing-space',
        },
        -- enable = false,
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
        unusedLocalExclude = {
          '_*',
        },
      },
    },
  },
}
