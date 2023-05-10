local ok, cmp = b4.pequire('cmp')

if not ok then
  vim.notify('Could not load the "nvim-cmp" plugin')
  return
end

local mapping_sources = {
  { name = 'nvim_lsp' },
  { name = 'nvim_lua' },
  { name = 'luasnip' },
  { name = 'path' },
  { name = 'buffer', keyword_length = 2 }
}

cmp.setup({
  -- completion = {
  --   completeopt = "menu,menuone,noinsert",
  -- },

  enabled = function()
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    elseif vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
      return false
    else
      local context = require('cmp.config.context')

      return not context.in_treesitter_capture("comment")
      and not context.in_syntax_group("Comment")
    end
  end,

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  window = {
    documentation = {
      border = 'single'
    }
  },

  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' }
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-q>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping.complete({ config = { sources = mapping_sources } }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
  }),

  sources = mapping_sources,

  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',
      maxwidth = 40,
    })
  },

  sorting = {
    comparators = {
      cmp.config.compare.exact,
      require("clangd_extensions.cmp_scores"),
      cmp.config.compare.offset,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  experimental = {
    ghost_text = true
  }
})
