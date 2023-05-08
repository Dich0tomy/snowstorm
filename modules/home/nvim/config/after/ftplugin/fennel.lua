vim.opt.listchars:remove({'lead'})
vim.g.indent_blankline_enabled = false
vim.opt.expandtab = true

vim.b.format_on_save = true

vim.g.maplocalleader = ','

-- local ls = require 'luasnip'
-- local snippet = ls.snippet
-- local text = ls.text_node
-- local insert = ls.insert_node
-- local fmt = require 'luasnip.extras.fmt'.fmt

-- local make_function_like_snippet = function(name)
-- 	return snippet(
-- 		name,
-- 		{
-- 			fmt(
-- 				[[
-- 				({} {} [{}]
-- 					{})
-- 				]],
-- 				{
-- 					text(name),
-- 					insert(1, '<name>'),
-- 					insert(2, '<args>'),
-- 					insert(3, '<body>'),
-- 				}
-- 			)
-- 		}
-- 	)
-- end
--
-- local lam_snippet = make_function_like_snippet('lambda')
-- local fn_snippet = make_function_like_snippet('fn')
-- local macro_snippet = make_function_like_snippet('macro')
--
-- ls.add_snippets(
--   'fennel',
-- 	{
-- 		lam_snippet,
-- 		fn_snippet,
-- 		macro_snippet
-- 	}
-- ){}

