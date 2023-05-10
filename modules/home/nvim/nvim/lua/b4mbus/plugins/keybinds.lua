local keymap = vim.keymap.set
local silent = { silent = true }
local silent_noremap = { silent = true, noremap = true }
local silent_remap = { silent = true, remap = true }

-- Ctrl + Return closes a buffer
keymap("n", "<C-cr>", "<cmd>lua MiniBufremove.delete(0, true)<cr>", silent_noremap)

-- H and L cycle buffers
keymap("n", "H", "<cmd>BufferLineCyclePrev<cr>", silent_noremap)
keymap("n", "L", "<cmd>BufferLineCycleNext<cr>", silent_noremap)

-- <A-hjkl> resize buffers
keymap('n', '<C-A-h>', function() require('smart-splits').resize_left() end, silent_noremap)
keymap('n', '<C-A-j>', function() require('smart-splits').resize_down() end, silent_noremap)
keymap('n', '<C-A-k>', function() require('smart-splits').resize_up() end, silent_noremap)
keymap('n', '<C-A-l>', function() require('smart-splits').resize_right() end, silent_noremap)

-- Text case keymappings
keymap('n', 'gau', function() require('textcase').current_word('to_upper_case') end, silent_noremap)
keymap('n', 'gal', function() require('textcase').current_word('to_lower_case') end, silent_noremap)
keymap('n', 'gas', function() require('textcase').current_word('to_snake_case') end, silent_noremap)
keymap('n', 'gad', function() require('textcase').current_word('to_dash_case') end, silent_noremap)
keymap('n', 'gan', function() require('textcase').current_word('to_constant_case') end, silent_noremap)
keymap('n', 'gad', function() require('textcase').current_word('to_dot_case') end, silent_noremap)
keymap('n', 'gaa', function() require('textcase').current_word('to_phrase_case') end, silent_noremap)
keymap('n', 'gac', function() require('textcase').current_word('to_camel_case') end, silent_noremap)
keymap('n', 'gap', function() require('textcase').current_word('to_pascal_case') end, silent_noremap)
keymap('n', 'gat', function() require('textcase').current_word('to_title_case') end, silent_noremap)
keymap('n', 'gaf', function() require('textcase').current_word('to_path_case') end, silent_noremap)

keymap('n', 'gaU', function() require('textcase').lsp_rename('to_upper_case') end, silent_noremap)
keymap('n', 'gaL', function() require('textcase').lsp_rename('to_lower_case') end, silent_noremap)
keymap('n', 'gaS', function() require('textcase').lsp_rename('to_snake_case') end, silent_noremap)
keymap('n', 'gaD', function() require('textcase').lsp_rename('to_dash_case') end, silent_noremap)
keymap('n', 'gaN', function() require('textcase').lsp_rename('to_constant_case') end, silent_noremap)
keymap('n', 'gaD', function() require('textcase').lsp_rename('to_dot_case') end, silent_noremap)
keymap('n', 'gaA', function() require('textcase').lsp_rename('to_phrase_case') end, silent_noremap)
keymap('n', 'gaC', function() require('textcase').lsp_rename('to_camel_case') end, silent_noremap)
keymap('n', 'gaP', function() require('textcase').lsp_rename('to_pascal_case') end, silent_noremap)
keymap('n', 'gaT', function() require('textcase').lsp_rename('to_title_case') end, silent_noremap)
keymap('n', 'gaF', function() require('textcase').lsp_rename('to_path_case') end, silent_noremap)

keymap('n', 'geu', function() require('textcase').operator('to_upper_case') end, silent_noremap)
keymap('n', 'gel', function() require('textcase').operator('to_lower_case') end, silent_noremap)
keymap('n', 'ges', function() require('textcase').operator('to_snake_case') end, silent_noremap)
keymap('n', 'ged', function() require('textcase').operator('to_dash_case') end, silent_noremap)
keymap('n', 'gen', function() require('textcase').operator('to_constant_case') end, silent_noremap)
keymap('n', 'ged', function() require('textcase').operator('to_dot_case') end, silent_noremap)
keymap('n', 'gea', function() require('textcase').operator('to_phrase_case') end, silent_noremap)
keymap('n', 'gec', function() require('textcase').operator('to_camel_case') end, silent_noremap)
keymap('n', 'gep', function() require('textcase').operator('to_pascal_case') end, silent_noremap)
keymap('n', 'get', function() require('textcase').operator('to_title_case') end, silent_noremap)
keymap('n', 'gef', function() require('textcase').operator('to_path_case') end, silent_noremap)

keymap("n", "gK", '<cmd>TSJSplit<cr>', silent_noremap)
keymap("n", "gJ", '<cmd>TSJJoin<cr>', silent_noremap)

keymap('n', 'cq', function() require('replacer').run() end, silent_noremap)

keymap('n', '<M-r>', '<Plug>RestNvim', silent_noremap)

local ok, ufo = b4.pequire('ufo')

if ok then
  keymap('n', 'zR', require('ufo').openAllFolds, silent_remap)
  keymap('n', 'zM', require('ufo').closeAllFolds, silent_remap)
  keymap('n', 'zM', require('ufo').closeAllFolds, silent_remap)
  keymap('n', 'zr', require('ufo').openFoldsExceptKinds, silent_remap)
  keymap('n', 'zm', require('ufo').closeFoldsWith, silent_remap)
end

keymap('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)

keymap(
  "x",
  "g?",
  function()
    local ok, pantran = b4.pequire('pantran')
    if ok then
      return pantran.motion_translate()
    end
  end,
  { remap = true, silent = true, expr = true }
)

local dbg_map = function(suffix, thing)
  keymap('n', '<leader>d' .. suffix, thing)
end

dbg_map('c', function() require 'dap'.continue() end)
dbg_map('o', function() require 'dap'.step_over() end)
dbg_map('i', function() require 'dap'.step_into() end)
dbg_map('l', function() require 'dap'.step_out() end)
dbg_map(
  'L',
  function()
    local dap = require 'dap'
    dap.step_into()
    dap.step_out()
  end
)

-- keymap('n', '<F5>', function() require'dap'.continue() end)
-- keymap('n', '<F6>', function() require'dap'.step_over() end)
-- keymap('n', '<F7>', function() require'dap'.step_into() end)
-- keymap('n', '<F8>', function() require'dap'.step_out() end)

dbg_map('b', function() require 'dap'.toggle_breakpoint() end)
dbg_map('B', function() require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
dbg_map('p', function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)

dbg_map('r', function() require 'dap'.repl.open() end)
dbg_map('t', function() require 'dapui'.close() end)
