local ok, truezen = b4.pequire('true-zen')
if not ok then
  vim.notify('Could not load the "true-zen" plugin')
  return
end

local tmux_status_off = function() vim.cmd('!tmux status off') end
local tmux_status_on = function() vim.cmd('!tmux status on') end

local cb = {
  open_pre = nil,
  open_pos = tmux_status_off,
  close_pre = nil,
  close_pos = tmux_status_on,
}

local cbs = {
  callbacks = cb
}

truezen.setup({
  ataraxis = {
    minimum_writing_area = { -- minimum size of main window
      width = 120,
    },
    callbacks = cb
  },
  minimalist = cbs,
  narrow = cbs,
  focus = cbs
})

local keymap = vim.keymap.set

keymap(
  'n',
  '<leader>zn',
  function()
    local first = 0
    local last = vim.api.nvim_buf_line_count(0)
    truezen.narrow(first, last)
  end,
  { noremap = true }
)

keymap(
  'v',
  '<leader>zn',
  function()
    local first = vim.fn.line('v')
    local last = vim.fn.line('.')
    truezen.narrow(first, last)
  end,
  { noremap = true }
)

keymap('n', '<leader>zf', truezen.focus, { noremap = true })
keymap('n', '<leader>zm', truezen.minimalist, { noremap = true })
keymap('n', '<leader>za', truezen.ataraxis, { noremap = true })
