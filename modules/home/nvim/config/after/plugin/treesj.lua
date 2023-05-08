local ok, tsj = b4.pequire('treesj')
if not ok then
  vim.notify('Could not load the "treesj" plugin')
  return
end

local langs = { }

tsj.setup({
  use_default_keymaps = false,
  check_syntax_error = true,
  max_join_length = 1000,
  cursor_behavior = 'hold',
  notify = true,
  langs = langs,
})
