vim.opt.exrc = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.shiftround = true
vim.opt.hlsearch = false
vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.expandtab = false
vim.opt.copyindent = true
vim.opt.lazyredraw = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.confirm = true
vim.opt.smartcase = true
vim.opt.showtabline = 1
vim.opt.shiftwidth = 2
vim.opt.pumheight = 10
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 8
vim.opt.tabstop = 2
vim.opt.timeoutlen = 350
vim.opt.laststatus = 3
vim.opt.history = 10000

vim.cmd('set colorcolumn=120')

vim.opt.grepprg = 'rg -n $* /dev/null'

vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.virtualedit = 'block'
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.inccommand = 'split'
vim.opt.listchars = {
  tab = '  ',
  -- lead = '·',
  nbsp = '␣',
  precedes = '«',
  extends = '»'
}
vim.opt.fillchars = {
  stl = ' ',
  stlnc = ' ',
  diff = '╱',
  fold = ' ',
  foldsep = ' ',
  foldclose = '',
  foldopen = '',
  eob = ' ',
  msgsep = '─'
}
vim.opt.diffopt = {
  algorithm = 'histogram',
  internal = true,
  ['indent-heuristic'] = true,
  filler = true,
  closeoff = true,
  iwhite = true,
  vertical = true
}
-- vim.opt.sessionoptions = {
--   'blank',
--   'buffers',
--   'curdir',
--   'folds',
--   'help',
--   'localoptions',
--   'options',
--   'resize',
--   'terminal',
--   'tabpages',
-- }
vim.opt.showbreak = "⤷ "
vim.opt.selection = 'old'
vim.opt.completeopt = { 'menu', 'menuone' ,'noselect' }

vim.o.formatoptions = "jqlnt"
