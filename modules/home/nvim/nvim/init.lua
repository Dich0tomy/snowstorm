-- local hotpot_path = vim.fn.stdpath('data') .. '/lazy/hotpot.nvim'

package.path = package.path .. ';/home/b4mbus/.luarocks/share/lua/5.1/?.lua;/home/b4mbus/.luarocks/share/lua/5.1/?/init.lua'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('b4mbus.prelude')

b4.xpnequire('b4mbus.core')
b4.xpnequire('b4mbus.plugins')
b4.xpnequire('b4mbus.theming')
