local cmp = require('cmp')

---@param args table
local function expand(args)
  require('luasnip').lsp_expand(args.body)
end

---@param predicate boolean When predicate is true, do fn(), else fallback()
---@param fn function Do this when predicate is true
---@param fallback function? Do this when predicate is false
local function fn_or(predicate, fn, fallback)
  if predicate then
    fn()
  elseif fallback ~= nil then
    fallback()
  end
end

---@param fallback function?
local function next(fallback)
  fn_or(cmp.visible(), cmp.select_next_item, fallback)
end

---@param fallback function?
local function prev(fallback)
  fn_or(cmp.visible(), cmp.select_prev_item, fallback)
end

---@type table<string, function>
local keymaps = {
  ['<Tab>'] = next,
  ['<S-Tab>'] = prev,
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
}

---@alias Source { name: string, trigger_characters: string[] | nil } `cmp.SourceConfig`
---@type Source[]
local sources = {
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
  { name = 'buffer' },
  { name = 'path', trigger_characters = { '/' } },
}

---@return boolean enabled Whether or not completion should activate
local function enabled()
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')

  ---@type table
  local ctx = require('cmp.config.context')
  ---@type boolean
  local in_comment = ctx.in_syntax_group('Comment')
    or ctx.in_treesitter_capture('comment')

  return buftype == '' and not in_comment
end

---@type table<string, string>
local icons = {
  Array = '',
  Boolean = '',
  Class = '',
  Color = '',
  Constant = '',
  Constructor = '',
  Copilot = '',
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = '',
  File = '',
  Folder = '',
  Function = '',
  Interface = '',
  Key = '',
  Keyword = '',
  Method = '',
  Module = '',
  Namespace = '',
  Null = '',
  Number = '',
  Object = '',
  Operator = '',
  Package = '',
  Property = '',
  Reference = '',
  Snippet = '',
  String = '',
  Struct = '',
  Text = '',
  TypeParameter = '',
  Unit = '',
  Value = '',
  Variable = '',
}

---@param item table A `vim.CompletedItem` (see `cmp.types.vim`)
---@return table item Formatted `vim.CompletedItem`
local function format(_, item)
  if icons[item.kind] then
    item.kind = string.format('%s %s', icons[item.kind], item.kind)
  end
  return item
end

local colours = require('nedia.colours')

---@type table<string, table>
local highlights = {
  CmpItemAbbrDeprecated = { fg = colours.grey, strikethrough = true },
  CmpItemAbbrMatch = { fg = colours.neutral_blue, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = colours.neutral_blue, bold = true },
  CmpItemKindClass = { fg = colours.neutral_purple },
  CmpItemKindColor = { fg = colours.neutral_aqua },
  CmpItemKindConstant = { fg = colours.neutral_red },
  CmpItemKindConstructor = { fg = colours.neutral_red },
  CmpItemKindEnum = { fg = colours.neutral_green },
  CmpItemKindEnumMember = { fg = colours.neutral_yellow },
  CmpItemKindEvent = { fg = colours.bright_purple },
  CmpItemKindField = { fg = colours.neutral_yellow },
  CmpItemKindFile = { fg = colours.bright_purple },
  CmpItemKindFolder = { fg = colours.bright_purple },
  CmpItemKindFunction = { fg = colours.neutral_blue },
  CmpItemKindInterface = { fg = colours.neutral_aqua },
  CmpItemKindKeyword = { fg = colours.neutral_green },
  CmpItemKindMethod = { fg = colours.neutral_blue },
  CmpItemKindModule = { fg = colours.neutral_red },
  CmpItemKindOperator = { fg = colours.neutral_red },
  CmpItemKindProperty = { fg = colours.neutral_yellow },
  CmpItemKindReference = { fg = colours.neutral_red },
  CmpItemKindSnippet = { fg = colours.neutral_blue },
  CmpItemKindStruct = { fg = colours.neutral_purple },
  CmpItemKindText = { fg = colours.neutral_green },
  CmpItemKindTypeParameter = { fg = colours.neutral_aqua },
  CmpItemKindUnit = { fg = colours.neutral_yellow },
  CmpItemKindValue = { fg = colours.fg },
  CmpItemKindVariable = { fg = colours.fg },
  CmpItemMenu = { fg = colours.neutral_purple },
}

cmp.setup({
  completion = { completeopt = 'menu,menuone,noinsert' },
  enabled = enabled,
  experimental = { ghost_text = { hl_group = '@comment' } },
  formatting = { format = format },
  mapping = cmp.mapping.preset.insert(keymaps),
  snippet = { expand = expand },
  sources = cmp.config.sources(sources),
})

-- Configure autopairs
cmp.event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)

-- Set highlights
for name, hl in pairs(highlights) do
  vim.api.nvim_set_hl(0, name, hl)
end
