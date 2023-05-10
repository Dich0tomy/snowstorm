return {
	'Pocco81/true-zen.nvim',
	event = 'BufEnter',
	config = function() require 'true-zen'.setup() end
}
