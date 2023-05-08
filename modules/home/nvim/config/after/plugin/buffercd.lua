local ok, buffercd = b4.pequire('buffercd')

if not ok then
  vim.notify('Could not load the "buffercd" plugin')
  return
end

buffercd.setup()
