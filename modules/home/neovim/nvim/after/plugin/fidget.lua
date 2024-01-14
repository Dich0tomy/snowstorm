local ok, fidget = b4.pequire('fidget')

if not ok then
  vim.notify('Could not load the "fidget" plugin')
  return
end

fidget.setup()
