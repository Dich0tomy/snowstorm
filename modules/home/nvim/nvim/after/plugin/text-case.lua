local ok, textcase = b4.pequire('textcase')

if not ok then
  vim.notify('Could not load the "textcase" plugin')
  return
end

textcase.setup()
