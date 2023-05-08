local ok, paint = b4.pequire('paint')
if not ok then
  vim.notify('Could not load the "paint" plugin')
  return
end

local tmux = function(pat, hl)
  return { filter = { filetype = 'tmux'  }, pattern = pat, hl = hl }
end

--- Generates a highlight for mdx
---@param pat string lua pattern
---@param hl string highlight name
---@return table
local jsx = function(pat, hl)
  return { filter = { filetype = 'jsx'  }, pattern = pat, hl = hl }
end
--
--- Generates a highlight for markdown
---@param pat string lua pattern
---@param hl string highlight name
---@return table
local md = function(pat, hl)
  return { filter = { filetype = 'markdown'  }, pattern = pat, hl = hl }
end

-- comments

paint.setup({
  highlights = {
    tmux('%s*#%s*(%[.-]:)', '@method'),
    tmux('%s*#%s*@(.*)', 'Constant'),
    tmux('<prefix>', '@attribute'),
    tmux('<prefix> (%+)', '@constructor'),
    tmux('<prefix> %+ (.+)', '@character'),
    tmux('<prefix> %+ (.+)', '@character'),

    --- JSX

    -- links
    jsx('(%[).-]%(.-%)', '@punctuation.delimiter'),
    jsx('%[.-(])%(.-%)', '@punctuation.delimiter'),

    jsx('%[.-](%().-%)', '@punctuation.delimiter'),
    jsx('%[.-]%(.-(%))', '@punctuation.delimiter'),

    jsx('%[(.-)]%(.-%)', '@text.reference'),
    jsx('%[.-]%((.-)%)', '@text.uri'),

    -- imports
    jsx([[^(import)%s+.-%s+from%s+['"].-['"];?]], '@conditional'),
    jsx([[^import%s+(.-)%s+from%s+['"].-['"];?]], 'Keyword'),
    jsx([[^import%s+.-%s+(from)%s+['"].-['"];?]], '@conditional'),
    jsx([[^import%s+.-%s+from%s+(['"].-['"]);?]], 'String'),

    -- comments
    jsx('(<!--.*-->)', '@comment'),

    -- tags
    jsx('</?([%a%d_]+).-/?>?', '@tag'),

    jsx('(</)[%a%d_]+.-/?>?', '@tag.delimter'),
    jsx('</[%a%d_]+.-(/?>?)', '@tag.delimter'),

    jsx('/?>', '@tag.delimiter'),
    jsx('</?', '@tag.delimiter'),

    jsx('<([%a%d_]+).-/?>?', '@tag'),

    -- &lt; &gr; weird ass
    jsx('&.-;', 'Constant'),
    jsx('&.-;', 'Bold'),

    --- markdown elements

    -- headings
    jsx('^(#) .-$', '@neorg.headings.1.prefix'),
    jsx('^# (.-)$', '@neorg.headings.1.title'),

    jsx('^(##) .-$', '@neorg.headings.2.prefix'),
    jsx('^## (.-)$', '@neorg.headings.2.title'),

    jsx('^(###) .-$', '@neorg.headings.3.prefix'),
    jsx('^### (.-)$', '@neorg.headings.3.title');

    jsx('^(####) .-$', '@neorg.headings.4.prefix'),
    jsx('^#### (.-)$', '@neorg.headings.4.title'),

    jsx('(%b``)', '@text.literal'),

    jsx('(%*%*.-%*%*)', '@punctuation.delimiter'),
    jsx('%*%*(.-)%*%*', '@text.strong'),

    jsx('(__.-__)', '@punctuation.delimiter'),
    jsx('__(.-)__', '@text.underline'),

    jsx('(%*.-%*)', '@punctuation.delimiter'),
    jsx('%*(.-)%*', '@text.emphasis'),

    -- strings
    jsx('(%b"")', '@string'),
    jsx("(%b'')", '@string'),

    md('(<!--.*-->)', '@comment'),
  },
})
