-- STOLEN FROM https://github.com/echasnovski/nvim/blob/master/after/ftplugin/markdown.lua#L27-L44

vim.cmd([[setlocal wrap]])
vim.cmd([[setlocal expandtab]])

-- Use custom folding based on treesitter parsing
vim.cmd([[setlocal foldmethod=expr]])
vim.cmd([[setlocal foldexpr=v:lua.b4.markdown_foldexpr()]])
vim.cmd([[normal! zx]]) -- Update folds

local has_mini_ai, mini_ai = pcall(require, 'mini.ai')
if has_mini_ai then
  vim.b.miniai_config = {
    custom_textobjects = {
      ['*'] = mini_ai.gen_spec.pair('*', '*', { type = 'greedy' }),
      ['_'] = mini_ai.gen_spec.pair('_', '_', { type = 'greedy' }),
    },
  }
end

local has_mini_surround, mini_surround = pcall(require, 'mini.surround')
if has_mini_surround then
  vim.b.minisurround_config = {
    custom_surroundings = {
      -- Bold
      B = { input = { '%*%*().-()%*%*' }, output = { left = '**', right = '**' } },

      -- Link
      L = {
        input = { '%[().-()%]%(.-%)' },
        output = function()
          local link = mini_surround.user_input('Link: ')
          return { left = '[', right = '](' .. link .. ')' }
        end,
      },
    },
  }
end
