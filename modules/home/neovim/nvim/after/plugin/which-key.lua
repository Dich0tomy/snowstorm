local ok, wk = b4.pequire('which-key')

if not ok then
  vim.notify('Could not load the "which-key" plugin')
end

local ok_symbols, symbols = b4.pequire('b4mbus.symbols')

if not ok then
  vim.notify('Could not load symbols for which key')
  return
end

wk.setup({
  window = {
    border = 'single'
  },
  icons = {
    separator = '⸬',
    group = symbols.horizontal_ellipsis .. ' '
  },
  key_labels = { ["<leader>"] = "SPC" },
  triggers = 'auto',
  show_help = false,
  show_keys = false
})

local telescope_mappings = {
  name = 'Telescope',
  f = { '<cmd>Telescope find_files<cr>', 'Find files' },
  F = { '<cmd>Telescope file_browser<cr>', 'File browser' },
  g = { '<cmd>Telescope egrepify<cr>', 'Live grep' },
  G = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Live grep' },
  h = { '<cmd>Telescope help_tags<cr>', 'Help' },
  k = { '<cmd>Telescope keymaps<cr>', 'Mappings' },
  c = { '<cmd>Telescope commands<cr>', 'Commands' },
  H = { '<cmd>Telescope highlights<cr>', 'Highlights' },
  p = { '<cmd>Telescope projects<cr>', 'Projects' },
  b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
  r = { '<cmd>Telescope resume<cr>', 'Resume' },
  o = { '<cmd>Telescope oldfiles<cr>', 'Oldfiles' }
}

local terminal_mappings = {
  name = 'Terminal',
  t = { '<cmd>tabnew +term<cr>', 'Open terminal in new tab' },
  v = { '<cmd>vnew +term<cr>', 'Open terminal in vsplit' },
  n = { '<cmd>new +term<cr>', 'Open terminal in split' },
  c = { '<cmd>term<cr>', 'Open terminal in current buffer' },
}

local neogen_mappings = {
  name = 'Neogen',
  a = { function() require 'neogen'.generate() end, 'Generate' },
  f = { function() require 'neogen'.generate { type = 'func' } end, 'Generate for function' },
  t = { function() require 'neogen'.generate { type = 'type' } end, 'Generate for type' },
  c = { function() require 'neogen'.generate { type = 'class' } end, 'Generate for class' },
  F = { function() require 'neogen'.generate { type = 'file' } end, 'Generate for file' },
}

local git_log_cmd = [[Git log --abbrev-commit --decorate --date=short --pretty='%C(yellow)%h%C(auto)%d %s (%C(bold blue)%an%Creset, %C(blue)%ar%C(reset))']]

local git_mappings = {
  name = 'Git',
  b = { '<cmd>G branch<cr>', 'Branches' },
  s = { '<cmd>Telescope git_status<cr>', 'Status' },
  c = { '<cmd>Telescope git_bcommits<cr>', 'Local commits' },
  C = { '<cmd>Telescope git_commits<cr>', 'Commits' },
  d = { '<cmd>DiffviewOpen<cr>', 'Diffview' },
  l = { ('<cmd>%s -50<cr>'):format(git_log_cmd), 'Small log (50)' },
  L = { ('<cmd>%s<cr>'):format(git_log_cmd), 'Log' },
  w = { [[<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>]], 'Worktrees' }

}

local buffer_mappings = {
  name = 'Buffers',
  l = { '<cmd>BufferLineCloseRight<cr>', 'Close to the right' },
  h = { '<cmd>BufferLineCloseLeft<cr>', 'Close to the left' },
  H = { '<cmd>hide<cr>', 'Hide' },
  p = { '<cmd>BufferLineTogglePin<cr>', 'Toggle pin' },
  P = {
    name = 'Pick',
    p = { '<cmd>BufferLinePick<cr>', 'Open' },
    c = { '<cmd>BufferLinePickClose<cr>', 'Close' }
  }
}

local iswap_mappings = {
  name = 'ISwap',
  i = { '<cmd>ISwap<cr>', 'General' },
  w = { '<cmd>ISwapWith<cr>', 'With' },
  n = { '<cmd>ISwapNode<cr>', 'Node' },
  l = { '<cmd>ISwapNodeWithLeft<cr>', 'With left' },
  h = { '<cmd>ISwapNodeWithRight<cr>', 'With right' },
}

-- All the default keymapings
wk.register(
  {
    [' '] = { 'i <C-o>a <Esc>h', 'Space'},
    y = { '<cmd>silent :%y<cr>', 'Yank buffer'},
    e = { '<c-w>v<cmd>Oil<cr>', 'Open dirbuf' },
    ["ss"] = {
      function()
        if vim.bo.ft == 'vim' or vim.bo.ft == 'lua' then vim.cmd.source('%') end
      end,
      'Source current file'
    },
    w = { '<cmd>silent :w<cr>', 'Save' },
    W = { '<cmd>silent :w!<cr>', 'Force save' },
    q = { '<cmd>silent :q<cr>', 'Save and quit' },
    Q = { '<cmd>silent :q!<cr>', 'Force save and quit' },
    n = neogen_mappings,
    b = buffer_mappings,
    s = telescope_mappings,
    t = terminal_mappings,
    g = git_mappings,
    i = iswap_mappings
  },
  { prefix = '<leader>' }
)

local visual_refactoring_mappings = {
  name = 'Refactoring',
  e = {
    name = 'Extract',
    f = { [[ <esc><cmd>lua require('refactoring').refactor('Extract Function')<cr> ]], 'Function' },
    F = { [[ <esc><cmd>lua require('refactoring').refactor('Extract Function To File')<cr> ]], 'Function to other file' },
    v = { [[ <esc><cmd>lua require('refactoring').refactor('Extract Variable')<cr> ]], 'Variable' },
  },
  i = { [[ <esc><cmd>lua require('refactoring').refactor('Inline varaible')<cr> ]], 'Inline variable' },
  d = {
    name = 'Debug',
    v = { [[ <cmd>lua require('refactoring').debug.print_var({})<cr> ]], 'Variable' },
  }
}

wk.register(
  {
    r = visual_refactoring_mappings,
    n = ('<cmd>norm! @%s<cr>'):format(vim.fn.reg_recorded())
  },
  { prefix = '<leader>', mode = 'x' }
)
