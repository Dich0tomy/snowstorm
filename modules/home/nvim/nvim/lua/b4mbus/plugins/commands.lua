local command = function(name, thing, tab)
  if not name then
    b4.nerror('Name is nil, cannot register command')
    return
  end
  if not thing then
    b4.nerror(('[%s] Thing is nil, cannot register command'):format(name))
    return
  end

  if not tab or vim.tbl_isempty(tab) then
    vim.api.nvim_create_user_command(name, thing, {})
  else
    vim.api.nvim_create_user_command(name, thing, tab)
  end
end

command(
  'Hologram',
  function()
    local ok, image = b4.pequire('hologram.image')
    if not ok then
      b4.nerror('Hologram not found')
      return
    end

    local buf = vim.api.nvim_get_current_buf()

    -- vim.api.nvim_buf_set_lines(buf, 1, -1, false, {''})

    image:new(vim.fn.expand('%:p'), {}):display(1, 0, buf, {})

    vim.bo.modified = false
    vim.bo.modifiable = false
  end,
  {}
)

-- :Trim trims spaces
command('Trim', function() MiniTrailspace.trim() end)

command('Aloof', 'source Session.vim')

command('MS', 'Obsession Session.vim')


command(
  'Dealoof',
  function()
    vim.cmd([[
      let s:choice = confirm("Are u sure you want to delete the session?", "&A Yes\n&S No", "Question")

      if s:choice == 1
        exe "Obsession!"
        lua b4.ninfo("Session deleted.")
      endif
    ]])
  end
)

command(
  'Wt',
  function(args)
    local fargs = args.fargs
    local ok, wt = b4.pequire('git-worktree')
    if not ok then
      b4.nerror('Git-worktree plugin is not installed.')
      return
    end

    if fargs[1] == 'create' then
      if #fargs ~= 4 then
        b4.nerror("At least 3 additional argument expected.\nWt create <dirname> <branch name> <upstream>")
        return
      end

      local path = vim.fn.expand('~/dev/worktrees/' .. fargs[2])

      wt.create_worktree(path, fargs[3], fargs[4])

    elseif fargs[1] == 'switch' then
      if #fargs ~= 2 then
        b4.nerror("At least 1 additional argument expected.\nWt create <dirname>")
        return
      end

      wt.switch_worktree(fargs[2])

    elseif fargs[1] == 'delete' then
      if #fargs ~= 2 then
        b4.nerror("At least 1 additional argument expected.\nWt create <dirname>")
        return
      end

      wt.delete_worktree(fargs[2])

    elseif fargs[1] == 'follow' then
    else
      b4.nerror("Invalid subcommand %s", fargs[1])
    end
  end,
  {
    nargs = '*',
    complete = function (_, line)
      local cmd = vim.split(vim.trim(line), '%s+')
      table.remove(cmd, 1)

      local primary_completions = { 'create', 'switch', 'delete', 'follow' }
      local number_of_completed = #cmd

      if number_of_completed == 0 then
        return primary_completions
      end
    end
  }
)
