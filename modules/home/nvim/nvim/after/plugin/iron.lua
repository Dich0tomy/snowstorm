local ok, iron = b4.pequire('iron.core')
if not ok then
  vim.notify('Could not load the "iron" plugin')
  return
end

iron.setup {
  config = {
    scratch_repl = true,
    repl_definition = {
      sh = {
        command = { "fish" }
      },
      ruby = {
        command = { 'irb' }
      }
    },
    repl_open_cmd = require('iron.view').split.vertical.botright(0.4)
,
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<C-c>c",
    visual_send = "<C-c>c",
    send_file = "<C-c>f",
    send_line = "<C-c><C-c>",
    send_mark = "<C-c>m",
    mark_motion = "<C-c>mc",
    mark_visual = "<C-c>mc",
    remove_mark = "<C-c>md",
    cr = "<C-c><cr>",
    interrupt = "<C-c><space>",
    exit = "<C-c>q",
    clear = "<C-c>l",
  },
  highlight = {
    italic = true
  },
  ignore_blank_lines = true,
}
