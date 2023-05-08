local api = vim.api
local augroup = function(name)
	api.nvim_create_augroup(name, { clear = true })
end
local autocmd = api.nvim_create_autocmd

-- yoinked and modified from folke's dots
autocmd("BufWritePre", {
  callback = function()
    if vim.tbl_contains({ "oil" }, vim.bo.ft) then
      return
    end
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- yoinked and modified from folke's dots
autocmd(
  'BufReadPre',
  {
    pattern = "*",
    callback = function()
      api.nvim_create_autocmd(
        "FileType",
        {
          pattern = "<buffer>",
          once = true,
          callback = function()
            vim.cmd([[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]])
          end,
        }
      )
    end,
  }
)

-- yoinked and modified from folke's dots
autocmd(
  'TextYankPost',
  {
    pattern = '*',
    callback = function()
      vim.highlight.on_yank({ higroup = 'YankPost' })
    end
  }
)

autocmd(
  'BufRead',
  {
    pattern = '*.mdx',
    command = 'setlocal ft=jsx'
  }
)

-- yoinked and modified from folke's dots
autocmd('FileType', {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function()
    api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>close<cr>', { silent = true })
    api.nvim_buf_set_option(0, 'buflisted', false)
  end,
})

--[[ autocmd(
  'BufWinEnter',
  {
    pattern = '*',
    callback = function()
      local bt = api.nvim_buf_get_option(0, 'bt')
      if bt ~= '' then return end

      local lines = api.nvim_buf_get_lines(0, 0, -1, true)

      local current = 1
      local markers = {}

      for line_nr, line in ipairs(lines) do
        if line:find('{{{') then
          markers[current] = { mbeg = line_nr }
        elseif line:find('}}}') then
          if not markers[current] then
            b4.nerror('Unbalanced opening brackets.')
            return
          end
          markers[current].mend = line_nr
          current = current + 1
        end
      end

      -- Here we are sure the markers are set correctly
      for _, marker in ipairs(markers) do
        local foldcmd = (':%s,%sfold'):format(marker.mbeg, marker.mend)

        vim.cmd(foldcmd)
        vim.cmd(foldcmd .. 'open')
      end
    end
  }
) ]]

autocmd(
  'TermOpen',
  {
    command = 'setlocal nonu nornu'
  }
)

autocmd(
  'BufEnter',
  {
    pattern = '*.cpp,*.hpp',
    callback = function()
      local vertical_ellipsis = '⋮'
      local commercial_at = '@'
      local colon = ':'

      vim.cmd([[ syntax keyword Keyword template conceal ]])
      vim.cmd(([[ syntax match PreProc "std::" conceal cchar=%s ]]):format(colon))
      vim.cmd([[ syntax match PreProc "#include " conceal  ]])
      vim.cmd(([[ syntax match Keyword "typename\.\.\." conceal cchar=%s ]]):format(vertical_ellipsis))
      vim.cmd([[ syntax match Keyword "typename " conceal ]])

      vim.opt.conceallevel = 2
    end
  }
)

autocmd(
  'BufRead',
  {
    group = vim.api.nvim_create_augroup('startup', { clear = false }),
    pattern = '*',
    callback = function()
      vim.api.nvim_create_autocmd(
        { 'InsertEnter', 'BufModifiedSet' },
        {
          buffer = 0,
          once = true,
          callback = function()
            vim.fn.setbufvar(api.nvim_get_current_buf(), 'persist_the_shit_outta_this', 1)
          end,
        }
      )
    end,
  }
)
