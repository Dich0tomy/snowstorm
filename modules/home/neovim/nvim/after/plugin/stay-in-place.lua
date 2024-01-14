local ok, stay_in_place = b4.pequire('stay-in-place')

if not ok then
  vim.notify('Could not load the "stay-in-place" plugin')
  return
end

stay_in_place.setup({
  set_keymaps = true,
  preserve_visual_selection = true
})
