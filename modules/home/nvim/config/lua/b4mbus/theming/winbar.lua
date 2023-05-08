WinbarMod = {}

WinbarMod.winbar = function()
  -- local symbols = require('b4mbus.symbols')

  -- local tabpage = vim.fn.tabpagenr()
  -- local tabs = vim.tbl_map(
  --   function(tab)
  --     return '%#InactiveTab#' .. tab.tabnr
  --   end,
  --   vim.fn.gettabinfo()
  -- )
  -- local tabstring = table.concat(tabs, '%#TabSeparator# ' .. symbols.small_dot .. ' ');

  return '%=%#KurwaMac# %#IdkForFucksSakeLol# ' .. vim.fn.expand('%:t') .. ' %#none#'
end

vim.opt.winbar = '%{%v:lua.WinbarMod.winbar()%}'
