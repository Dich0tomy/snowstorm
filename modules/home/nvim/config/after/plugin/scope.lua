local ok, scope = b4.pequire('colorizer')

if not ok then
  vim.notify('Could not load the "scope" plugin')
  return
end

scope.setup()
