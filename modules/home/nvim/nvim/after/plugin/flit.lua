local ok, flit = b4.pequire('flit')
if not ok then
  vim.notify('Could not load the "flit" plugin')
  return
end

flit.setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  labeled_modes = "v",
  multiline = true,
  opts = {}
}
