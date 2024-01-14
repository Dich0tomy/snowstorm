local ok, neodev = b4.pequire('neodev')

if not ok then
  vim.notify('Could not load the "neodev" plugin')
  return
end

neodev.setup({
  library = { plugins = { 'neotest' }, types = true }
})
