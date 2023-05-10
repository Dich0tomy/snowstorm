local function trim(str)
  return str:gsub('^%s*(.-)%s*$', '%1')
end

local Common = {}

function Common.notify(text)
  local naughty = require('naughty')

  naughty.notify({
    text = text,
    timeout = 5
  })
end

function Common.is_executable(executable)
  local fs = require('gears.filesystem')

  local pipe = assert(io.popen('which ' .. executable, 'r'))
  local output_string = pipe:read('*a')

  if output_string:find('which: no') then
    return false
  end

  return fs.file_executable(trim(output_string))
end

return Common
