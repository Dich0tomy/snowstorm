return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  config = function ()
    require('lualine').setup {
      theme = 'mountain'
  }
  end,
  dependencies = { 'mountain-theme/vim' },
}
