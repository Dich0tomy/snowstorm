local ok, ufo = b4.pequire('ufo')

if not ok then
  vim.notify('Could not load the "ufo" plugin')
  return
end

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ('  %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, {chunkText, hlGroup})
      chunkWidth = vim.fn.strdisplaywidth(chunkText)

      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, {suffix, 'MoreMsg'})
  return newVirtText
end

ufo.setup({
  fold_virt_text_handler = handler
})

local bufnr = vim.api.nvim_get_current_buf()
ufo.setFoldVirtTextHandler(bufnr, handler)

--[[ vim.api.nvim_create_autocmd(
  'BufWinEnter',
  {
    pattern = '*',
    callback = function()
      local api = vim.api

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
        vim.schedule(
          function ()
            local foldcmd = (':%s,%sfold'):format(marker.mbeg, marker.mend)

            vim.cmd(foldcmd)
            vim.cmd(foldcmd .. 'open')
          end
        )
      end
    end
  }
) ]]
