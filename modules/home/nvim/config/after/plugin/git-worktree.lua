local ok, wt = b4.pequire('git-worktree')
if not ok then
  vim.notify('Could not load the "git worktree" plugin')
  return
end

-- wt.on_tree_change(function(op, meta)
--   b4.P("does that work", op, meta)

--   if op == wt.Operations.Create then
--     local o, Job = b4.pequire('plenary.job')
--     if o then
--       Job:new({
--         command = 'tmux',
--         args = {
--           [[new-window]],
--           ([["nvim %s"]]):format(meta.path),
--           [[\;]],
--           [[rename-window]],
--           ([["wt %s"]]):format(meta.upstream),
--         }
--       }):start()
--     end
--   end
-- end)
