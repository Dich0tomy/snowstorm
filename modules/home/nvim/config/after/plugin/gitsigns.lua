local ok, gitsigns = b4.pequire('gitsigns')
if not ok then
  vim.notify('Could not load the "gitsigns" plugin')
  return
end

gitsigns.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 100,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage hunk' })
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset hunk' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
    map('n', '<leader>hp', gs.preview_hunk_inline, { desc = 'Preview hunk inline' })
    map('n', '<leader>hb', gs.blame_line, { desc = 'Blame line' })

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})
