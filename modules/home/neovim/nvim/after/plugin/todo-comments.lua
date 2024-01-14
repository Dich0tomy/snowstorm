local ok, todo_comments = b4.pequire('todo-comments')
if not ok then
  vim.notify('Could not load the "todo-comments" plugin')
  return
end

todo_comments.setup()
