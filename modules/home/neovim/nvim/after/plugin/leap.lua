local ok, leap = b4.pequire('leap')
if not ok then
  vim.notify('Could not load the "leap" plugin')
  return
end

leap.add_default_mappings()
vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#707070' })
