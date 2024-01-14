local ok, ts_autotag = b4.pequire('nvim-ts-autotag')
if not ok then
  vim.notify('Could not load the "treesitter autotag" plugin')
  return
end

ts_autotag.setup()
