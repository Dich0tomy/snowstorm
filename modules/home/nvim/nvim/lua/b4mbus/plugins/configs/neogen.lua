return {
	'danymat/neogen',
	config = function ()
		require 'neogen'.setup {
      snippet_engine = 'luasnip',
      languages = {
        lua = {
          template = {
            annotation_convention = "emmylua"
          }
        }
      }
    }
  end
}
