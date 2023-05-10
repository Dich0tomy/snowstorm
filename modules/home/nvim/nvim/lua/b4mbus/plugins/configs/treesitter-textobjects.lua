return {
	'nvim-treesitter/nvim-treesitter-textobjects',
	event = { "BufRead", "BufNewFile" },
	config = function()
		require'nvim-treesitter.configs'.setup {
			textobjects = {
				select = {
					enable = false,
					lookahead = true,
					keymaps = {
						aF = '@function.outer',
						['iF'] = '@function.inner',

						ac = '@class.outer',
						ic = '@class.inner',

						ab = '@block.outer',

						as = '@statement.outer',

						ip = '@parameter.inner',

						iC = '@conditional.inner',
						aC = '@conditional.outer',

						il = '@loop.inner',
						al = '@loop.outer'
					},
					selection_modes = {
						['@parameter.outer'] = 'v', -- charwise
						['@function.outer'] = 'V', -- linewise
						['@class.outer'] = '<c-v>', -- blockwise
					}
				}
			}
		}
	end
}
