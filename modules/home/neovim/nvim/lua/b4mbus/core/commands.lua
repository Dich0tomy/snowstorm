local api = vim.api
local command = function(name, thing, tab)
  if not name then
    b4.nerror('Name is nil, cannot register command')
    return
  end
  if not thing then
    b4.nerror(('For command [%s] - thing is nil, cannot register command'):format(name))
    return
  end

  if not tab or vim.tbl_isempty(tab) then
    api.nvim_create_user_command(name, thing, {})
  else
    api.nvim_create_user_command(name, thing, tab)
  end
end

local msgbuf = function(args)
  api.nvim_exec([[enew | pu=execute(']] .. args.args ..  [[') ]], false)
end


command('Mb', msgbuf, { nargs = '*' })
command('MB', msgbuf, { nargs = '*' })

command(
  'Clone',
  function(args)
    local o, Job = b4.pequire('plenary.job')
    if not o then
      b4.nerror('Plenary job could not be found, cannot spawn git process.')
    end

    Job:new({
      command = 'git',
      args = {
        'clone',
        [[--depth]],
        '1',
        args.args
      },
      on_stderr = function(err, data)
        if err then
          b4.ninfo(err)
        end

        if data then
          b4.ninfo(data)
        end
      end,
    }):start()
  end,
  { nargs = 1 }
)

--[[ command(
  'Test',
  function(args)
    b4.P(args)
  end,
  {
    nargs = 1,
    complete = function(_, line)
      local cmd = vim.split(vim.trim(line), '%s+')
      table.remove(cmd, 1)

      local completions = { 'debug', 'suck' }

      local already_completed = #cmd
      if already_completed == 0 then
        return completions
      elseif already_completed == 1 then
        local idx = table.find(completions, cmd[1])
        return { 'debug', 'suck' }
      end
      return already_completed == 0 and { 'debug' } or {}
    end,
  }
) ]]

command(
  'InsertMIT',
  function()
    local mit_license_template = [[
MIT License

Copyright (c) %s %s

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.]]

    local mit_license = mit_license_template:format(
      os.date('*t').year,
      'Daniel Zaradny <danielzaradny@gmail.com>'
    )
    local i = 0

    for line in mit_license:gmatch("([^\n]*)\n?") do
      api.nvim_buf_set_lines(
        0,
        i,
        -1,
        false,
        { line }
      )
      i = i + 1
    end
  end,
  {}
)

command('Path', [[echo expand('%') expand('%:p') bufname()]], {})

command(
  'Sx',
  function(args)
    b4.Sx(args.line1, args.line2, args.args)
  end,
  { range = '%' }
)

command(
  'SBLL',
  function(args)
    b4.Sx(
      args.line1,
      args.line2,
      [[awk '{ print length(), $0 | "sort -nr" }' | cut -f2- -d" "]]
    )
  end,
  { range = '%' }
)

command(
  'Uniq',
  function(args)
    b4.Sx(
      args.line1,
      args.line2,
      [[awk '!visited[$0]++']]
    )
  end,
  { range = '%' }
)

command('Btop', 'tabedit term://btop')

command(
  'PomodoroMtf',
  function(args)
    local multiplier = 1000 * 60
    local milliseconds = multiplier * tonumber(vim.trim(args.args))

    b4.set_timeout(
      milliseconds,
      function()
        for _i = 1,11 do
          b4.ninfo('Pomodoro timeout motherfucker')
        end
      end
    )

    local minutes = milliseconds / multiplier
    b4.ninfo(('Timer set for %s minute%s!'):format(minutes, minutes == 1 and '' or 's'))
  end,
  { nargs = 1 }
)

command(
  'Quotes',
  function(args)
    vim.cmd(([[%s,%ss/"/'/ge]]):format(args.line1, args.line2))
  end,
  { range = true }
)

command(
  'ClearListChars',
  function()
    vim.opt.listchars = {
      tab = '  '
    }
  end
)

command(
  'LF',
  function(args)
    local m_beg, m_end = args.line1 - 1, args.line2
    local lines = vim.fn.split(vim.fn.join(api.nvim_buf_get_lines(0, m_beg, m_end, false)))

    local wrap = args.args[1] or '"'
    local delim = ('%s '):format(args.args[2] or ',')

    local list = vim.fn.join(
      vim.tbl_map(
        function(x)
          return ('%s%s%s'):format(wrap, x, wrap)
        end,
        lines
      ),
      delim
    )

    api.nvim_buf_set_lines(0, m_beg, m_end, false, { list })
    vim.cmd.normal((m_beg + 1 == m_end and '==' or 'gv='))
  end,
  { range = true, nargs = '*' }
 )

command(
  'FixFloatingWindow',
  function()
    local windows = api.nvim_list_wins()
    api.nvim_win_close(windows[#windows], true)
  end
)

local a = function()
  vim.opt.statuscolumn = ''
  vim.opt.statusline = ''
  vim.opt.tabline = ''
  vim.opt.winbar = ''

  vim.opt.statuscolumn = '%!v:lua._G.get_statuscol()'
  vim.opt.statusline = '%{%v:lua.StatuslineMod.statusline()%}'
  vim.opt.tabline = '%{%v:lua.TablineMod.tabline()%}'
  vim.opt.winbar = '%{%v:lua.WinbarMod.winbar()%}'
end

command('FixStatus', a)
command('FS', a)

command( -- Lua Exec
  'LE',
  function(args)
    local escape = vim.fn.escape
    api.nvim_exec2(
      [[pu=execute('lua local p,f=print,string.format;p(]] .. escape(args.args, [["']]) ..  [[)')]],
      { output = false }
    )
  end,
  { nargs = '*' }
)

command(
  'FK',
  function(args)
    local split, trim = vim.fn.split, vim.fn.trim

    local last_5_history_entries = split(api.nvim_exec2('history : -5,', { output = true }).output, '\n')
    table.remove(last_5_history_entries, 1)

    for _, cmd in ipairs(last_5_history_entries) do
      cmd = trim(cmd):gmatch("%d+ (.*)")()

      local substitution_pat = [[.-s/(.-[^\])/(.-[^\])/(.*)]]
      local prev_sub_from, prev_sub_to, prev_sub_flags = cmd:gmatch(substitution_pat)()

      if prev_sub_from and prev_sub_to and prev_sub_to ~= '' then
        local beginning_row = api.nvim_buf_get_mark(0, '<')[1]
        local ending_row = api.nvim_buf_get_mark(0, '>')[1]

        -- still to do lol
        local prev_substitution = vim.fn.substitute(prev_sub_from, prev_sub_to, "", prev_sub_flags)

        -- b4.P(
        --   ('%s, %ss/%s/%s'):format(beginning_row, ending_row, substitution, args.args),
        --   substitution,
        --   beginning_row,
        --   ending_row
        -- )

        -- api.nvim_exec2('undo', { output = false })
        -- api.nvim_exec2(
        --   (('%s, %ss/%s/%s'):format(beginning_row, ending_row, cmd, args.args)),
        --   { output = false }
        -- )
        break
      end
    end
  end,
  { nargs = '*' }
)

-- foooooooo()
-- foooooooo()
