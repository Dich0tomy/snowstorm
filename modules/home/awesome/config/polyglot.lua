local CyclicTable = require('cyclic_table')
local common = require('common')

local awful = require('awful')

local Polyglot = {}

local function set_layout(layout)
  if not common.is_executable('setxkbmap') then
    common.notify('Cannot find "setxkbmap" wtf???')
    return
  end

  awful.util.spawn_with_shell(('setxkbmap -layout %s'):format(layout))
end

function Polyglot:new(layouts)
  if #layouts < 1 then
    common.notify('Expected at least one layout')
  end

  Polyglot.layouts = CyclicTable:new(layouts)
  set_layout(self.layouts:next())

  return self
end

function Polyglot:set_next()
  local layout = self.layouts:next()
  set_layout(layout)
  common.notify(('Current layout is: %s'):format(layout))
end

return Polyglot
