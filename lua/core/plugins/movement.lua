return {
  {
    'ggandor/flit.nvim',
    dependencies = { 'ggandor/leap.nvim' },
    lazy = true,
    keys = {
      { 'f', mode = { 'n', 'x', 'o' } },
      { 'F', mode = { 'n', 'x', 'o' } },
    },
    opts = {
      keys = { f = 'f', F = 'F', t = '<Nop>', T = '<Nop>' },
      labeled_modes = 'nxo',
    },
  },
}
