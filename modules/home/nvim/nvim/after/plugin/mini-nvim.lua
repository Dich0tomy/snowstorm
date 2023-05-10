local ok, mini_ai = b4.pequire('mini.ai')

if not ok then
  vim.notify('Could not load the "mini.nvim" plugin')
  return
end

local spec_treesitter = require('mini.ai').gen_spec.treesitter
mini_ai.setup({
  custom_textobjects = {
    F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
    x = spec_treesitter({ a = '@comment.outer', i = '@comment.inner' }),
  }
})

require('mini.bufremove').setup({})
-- require('mini.pairs').setup({})

require('mini.surround').setup({
  mappings = {
    add = '<C-s>a', -- Add surrounding in Normal and Visual modes
    delete = '<C-s>d', -- Delete surrounding
    find = '<C-s>f', -- Find surrounding (to the right)
    find_left = '<C-s>F', -- Find surrounding (to the left)
    highlight = '<C-s>h', -- Highlight surrounding
    replace = '<C-s>r', -- Replace surrounding

    update_n_lines = '',

    suffix_last = '',
    suffix_next = ''
  },
})

require('mini.trailspace').setup({})

require('mini.align').setup({
  mappings = {
    start = 'gA',
    start_with_preview = 'ga',
  },
})
