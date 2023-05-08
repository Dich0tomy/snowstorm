local hl = function(...)
  vim.api.nvim_set_hl(0, ...)
end

local st_hl = function(name, hl)
  vim.api.nvim_set_hl(0, name, vim.tbl_extend('keep', { --[[ bg = '#17171e' ]] }, hl))
end

hl('IdkForFucksSake', { bg = '#111111'})
hl('IdkForFucksSakeLol', { bold = true, bg = '#111111'})

-- LSP Semantic Tokens

-- hl('@class', { fg = '#5599cc' })
-- hl('@struct', { fg = '#33f08f' })
-- hl('@enum', { fg = '#8147cf' })
-- hl('@enumMember', { fg = '#ff99cc' })
-- hl('@event', { fg = '#00bbff' })
-- hl('@interface', { fg = '#ffbb00' })
-- hl('@modifier', { fg = '#00ff00' })
-- hl('@regexp', { fg = '#00ffff' })
-- hl('@typeParameter', { fg = '#3388ff' })
-- hl('@decorator', { fg = '#0f0f01' })

hl('Tabline', { bg = 'none', bold = true  })
hl('ActiveTab', { fg = '#3388ff', bg = 'none', bold = true  })
hl('InactiveTab', { fg = '#ffffff', bg = 'none' })
hl('TabSeparator', { bg = 'none' })
hl('WinSeparator', { fg = '#8b008b', bg = 'none', })

st_hl('GitCommitStatusline', { fg = '#06cc71' })
st_hl('GitCommitStatuslineShort', { fg = '#005335', bold = true })

-- Obsession session status
st_hl('SessionActive', { fg = '#06cc81', bold = true })
st_hl('SessionInactive', { fg = '#737373', bold = true })

st_hl('NiceGrey', { fg = '#667789' })

-- hl('KurwaMac', { bg = '#3388ff' })
hl('KurwaMac', { bg = '#8b007b' })
hl('KurwaNieMac', { bg = '#b7008b' })

st_hl('KurwaMac3', { fg = '#ffffff', bg = '#111111', bold = true })
st_hl('KurwaMac2', { fg = '#ff0000', bg = '#111111', bold = true })

st_hl('White', { fg = '#ffffff' })
st_hl('Red', { fg = '#ff0000' })

st_hl('BoldWhite', { fg = '#ffffff', bold = true })
st_hl('BoldRed', { fg = '#ff0000', bold = true })
st_hl('BoldBlue', { fg = '#3388ff', bold = true })

-- hl('GitAddedSign', { fg = '#006B3D', bold = true })
-- hl('GitChangedSign', { fg = '#FF681E', bold = true })
-- hl('GitRemovedSign', { fg = '#94171F', bold = true })

st_hl('GitNew', { fg = '#ff0000', bold = true })
st_hl('GitAdded', { fg = '#069C56', bold = true })
st_hl('GitChanged', { fg = '#FF980E', bold = true })
st_hl('GitRemoved', { fg = '#D3212C', bold = true })

st_hl('GitBranchSign', { fg = '#525252', bold = true })
st_hl('GitBranch', { fg = '#A2A9B0', bold = true })

st_hl('StatusLineClock', { fg = '#ffffff', bold = true })
st_hl('StatusLineMode', { fg = '#ffffff', bold = true })

local szary_xd = '#6d8086'
st_hl('StatusLineBranchColor', { fg = szary_xd, bg = 'NONE' })
st_hl('StatusLineBold', { fg = szary_xd, bg = 'NONE', bold = true })

st_hl('StatusLine', {})
st_hl('st_none', {})

hl('Conceal', {})

st_hl('WildMenu', { fg = '#00bbff' })

hl('CmpItemAbbrDeprecated', { strikethrough = true, fg = '#808080', bg = 'NONE' })
hl('CmpItemAbbrMatch', { fg = '#569CD6', bg = 'NONE', bold = true })
hl('CmpItemAbbrMatchFuzzy', { fg = '#569CD6', bg = 'NONE', bold = true })

hl('CmpItemMenu', { fg = '#C792EA', bg = 'NONE', italic =  true })

-- Generic navic and cmp highlights
local lsp_types = {
	Field = { fg = '#EED8DA' },
	Property = { fg = '#EED8DA' },
	Event = { fg = '#EED8DA' },
	Text = { fg = '#9CDCFE' },
	Enum = { fg = '#C3E88D' },
	Keyword = { fg = '#C3E88D' },
	Constant = { fg = '#FFE082' },
	Constructor = { fg = '#FFE082' },
	Reference = { fg = '#FFE082' },
	Function = { fg = '#C586C0' },
	Method = { fg = '#C586C0' },
	Struct = { fg = '#EAAFB0' },
	Class = { fg = '#EA6111' },
	Module = { fg = '#EADFF0' },
	Operator = { fg = '#EADFF0' },
	Variable = { fg = '#9CDCFE' },
	File = { fg = '#C5CDD9' },
	Unit = { fg = '#F5EBD9' },
	Snippet = { fg = '#F5EBD9' },
	Folder = { fg = '#F5EBD9' },
	Value = { fg = '#DDE5F5' },
	EnumMember = { fg = '#DDE5F5' },
	Interface = { fg = '#9CDCFE' },
	Color = { fg = '#D8EEEB' },
	TypeParameter = { fg = '#D8EEEB' }
}

local prefixes = {
	'CmpItemKind',
	'NavicIcons'
}

for _, prefix in ipairs(prefixes) do
	for group, fg_hl in pairs(lsp_types) do
		local highlight = vim.tbl_extend('force', { bg = 'NONE'}, fg_hl)

		hl(prefix .. group, highlight)
	end
end
