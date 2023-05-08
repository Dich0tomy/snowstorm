local ok, telescope = b4.pequire('telescope')

if not ok then
  vim.notify('Could not load the "telescope" plugin')
  return
end

local actions = require('telescope.actions')
local layout_actions = require('telescope.actions.layout')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-c>'] = false,
        ['<C-n>'] = false,

        ['<M-p>'] = layout_actions.toggle_preview,

        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-h>'] = { '<C-o>0', type = 'command' },
        ['<C-l>'] = { '<C-o>$', type = 'command' },

        ['<C-p>'] = { '<C-r>+', type = 'command' },
      },
      n = {
        ['<M-p>'] = layout_actions.toggle_preview,
        ['<C-c>'] = actions.close,
        ['<C-p>'] = { 'i<C-r>+', type = 'command' },
      }
    }
  },
  extensions = {
    lazy = {
      theme = "ivy",
      show_icon = true,
      mappings = {
        open_in_browser = "<C-o>",
        open_in_find_files = "<C-f>",
        open_in_live_grep = "<C-g>",
        open_plugins_picker = "<C-b>",
      },
    },
    egrepify = {
      AND = true,
      lnum = true,
      lnum_hl = "EgrepifyLnum",
      col = false,
      col_hl = "EgrepifyCol",
      title_hl = "EgrepifyTitle",
      prefixes = {
        ["!"] = {
          flag = "invert-match",
        },
      },
    },
  }
})

telescope.load_extension('git_worktree')
telescope.load_extension "egrepify"
