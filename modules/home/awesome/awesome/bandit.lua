local common = require('common')

local gears_fs = require('gears.filesystem')
local naughty = require('naughty')
local awful = require('awful')

local fmt = string.format

local function get_shell_formatted_date_path()
  local scrot_format_path = ScreenshotDir

  if not os.getenv('SHELL'):find('fish') then
    scrot_format_path = scrot_format_path .. '$'
  end

  return scrot_format_path .. '(date +%F_%T).png'
end

local function requirements_satisfied()
  if not ScreenshotDir then
    common.notify('The ss dir has not been set.')
    return false
  end

  if not common.is_executable('scrot') then
    common.notify('The scrot executable is.. not an executable?.')
    return false
  end

  if not common.is_executable('xclip') then
    common.notify('The xclip executable is.. not an executable?.')
    return false
  end

  return true
end

local function issue_screenshot(opts)
  if not requirements_satisfied() then
    common.notify('The requirements have not been satisified, cannot make a screenshot.')
    return
  end

  local shell_formatted_path = get_shell_formatted_date_path()

  local xclip_commad = 'xclip -selection clipboard -t image/png $f'
  local additional_opts = opts and (opts .. ' ') or ''

  local scrot_cmd = fmt(
    [[ scrot %s %s -f --exec '%s']],
    shell_formatted_path,
    additional_opts,
    xclip_commad
  )

  awful.util.spawn_with_shell(scrot_cmd)
end

local Bandit = {}

function Bandit.set_ss_dir(dir)
  if not gears_fs.dir_readable(dir) then
    common.notify(fmt('The "%s" directory doesn\'t exist. Trying to create it.', dir))
    local ok, err = gears_fs.make_directories(dir)

    if not ok then
      common.notify(fmt('Couldn\'t create directory.\n\n%s', err))
      return
    end
  end

  ScreenshotDir = dir
end

function Bandit.quick_whole_screenshot()
  issue_screenshot()
end

function Bandit.selection_screenshot()
  issue_screenshot('-s')
end

function Bandit.window_screenshot()
  issue_screenshot('-u')
end

return Bandit
