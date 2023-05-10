--[[ local ok, lsp_lines = b4.pequire('lsp_lines')
if not ok then
  vim.notify('Could not load the "lsp-lines" plugin')
  return
end

lsp_lines.setup()

vim.diagnostic.config({
  virtual_lines = false
}) ]]
