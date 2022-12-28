local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
  },
}

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local sources = {
  { name = "buffer" },
  { name = "crates" },
  { name = "emoji" },
  { name = "luasnip" },
  { name = "neorg" },
  { name = "nvim_lsp" },
  { name = "nvim_lua" },
  { name = "path" },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")
  local has_neogen, neogen = pcall(require, "neogen")

  if cmp ~= nil then
    local select_next = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_neogen and neogen.jumpable() then
        neogen.jump_next()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end

    local select_prev = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif has_neogen and neogen.jumpable(true) then
        neogen.jump_prev()
      else
        fallback()
      end
    end

    cmp.setup({
      view = { entries = "native" },
      formatting = {
        source_names = {},
        format = lspkind.cmp_format({
          mode = "symbol_text",
          menu = {
            buffer = "(Buffer)",
            emoji = "(Emoji)",
            luasnip = "(LuaSnip)",
            nvim_lsp = "(LSP)",
            nvim_lua = "(Lua)",
            path = "(Path)",
          },
        }),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = sources,
      mapping = cmp.mapping.preset.insert({
        -- Tab:
        ["<Tab>"] = cmp.mapping(select_next),
        ["<S-Tab>"] = cmp.mapping(select_prev),

        -- Vim style movement:
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-K>"] = cmp.mapping.select_prev_item(),

        -- Arrow keys:
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),

        -- Complete:
        ["<CR>"] = cmp.mapping.confirm(),
        ["<C-Space>"] = cmp.mapping.confirm(),
      }),
      enabled = function()
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        else
          local context = require("cmp.config.context")
          return not context.in_treesitter_capture("comment")
            and not context.in_syntax_group("Comment")
        end
      end,
    })
  end
end

return M
