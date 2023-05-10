local ok, neogen = b4.pequire('neogen')

if not ok then
  vim.notify('Could not load the "neogen" plugin')
  return
end

neogen.setup()
