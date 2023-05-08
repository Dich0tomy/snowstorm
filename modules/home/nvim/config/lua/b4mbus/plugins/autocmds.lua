local augroup = function(name)
  vim.api.nvim_create_augroup(name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

autocmd(
  { 'BufReadPost' },
  {
    group = augroup('fugitive'),
    pattern = 'fugitive://*',
    command = 'set bufhidden=delete'
  }
)

autocmd(
  'FileType',
  {
    pattern = 'dap-repl',
    callback = function()
      require('dap.ext.autocompl').attach()
    end
  }
)
