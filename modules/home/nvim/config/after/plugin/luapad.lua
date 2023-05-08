local ok, luapad = b4.pequire('luapad')
if not ok then
  vim.notify('Could not load the "luapad" plugin')
  return
end

luapad.setup()
