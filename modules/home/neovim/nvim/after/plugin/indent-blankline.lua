--[[ local ok, indent_blankline = b4.pequire('indent_blankline')

if not ok then
  vim.notify('Could not load the "indent_blankline" plugin')
  return
end

indent_blankline.setup({
  space_char_blankline = ' ',
  show_current_context = true,
  show_current_context_start = true,
}) ]]
