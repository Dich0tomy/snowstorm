local ok, comment = b4.pequire('Comment')

if not ok then
  vim.notify('Could not load the "ccomment" plugin')
  return
end

comment.setup({
  ignore = '^$',
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
})
