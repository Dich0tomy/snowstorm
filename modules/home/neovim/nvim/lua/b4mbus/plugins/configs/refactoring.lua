return {
	'ThePrimeagen/refactoring.nvim',
	config = function()
		require 'refactoring'.setup {
			prompt_func_return_type = {
				cpp = true,
				cxx = true,
				hpp = true,
				c = true,
				h = true,
			},
			prompt_func_param_type = {
				cpp = true,
				cxx = true,
				hpp = true,
				c = true,
				h = true,
			},
			printf_statements = {
				cpp = {
					'(std::cout << "{{ [" << (%s) << "] called in [" << (%s) << "] }}\n");',
					'(fmt::print("{{ [{}] called in [{}] }}\n", (%s), (%s)));'
				}
			},
			print_var_statements = {
				cpp = {
					'(std::cout << "{{ %s [" << (%s) << "] }}\n");',
					'(fmt::print("{{ {} [{}] }}\n", (%s), (%s)));'
				}
			},
		}
	end
}
