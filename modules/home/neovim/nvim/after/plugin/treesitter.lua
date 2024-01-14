local ok, treesitter = b4.pequire('nvim-treesitter.configs')

if not ok then
  vim.notify('Could not load the "treesitter" plugin')
  return
end

treesitter.setup({
  ensure_installed = {
    'c',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'html',
    'rust',
    'fennel',
    'markdown',
    'markdown_inline',
    'haskell',
    'regex',
    'bash',
    'fish',
    'meson',
    'cpp',
    'norg',
    'norg_meta',
    'glsl',
    'nix',
  },

  sync_install = true,

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  },

  highlight = {
    enable = true,
    disable = function(lang, buf)
      if lang == 'comment' then return true end

      local max_filesize = 100 * 1024 -- 10 KB
      local fs_stat_ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if fs_stat_ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },

  matchparen = {
    enable = true
  },

  indent = {
    enable = true
  },

  playground = {
    enable = true,
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        aF = '@function.outer',
        ['iF'] = '@function.inner',

        ac = '@class.outer',
        ic = '@class.inner',

        ab = '@block.outer',

        as = '@statement.outer',

        ip = '@parameter.inner',

        ['ax'] = '@comment.outer',
        ['ix'] = '@comment.outer',

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
    },
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ["<leader>gp"] = "@function.outer",
        ["<leader>gP"] = "@class.outer",
      },
    },
  }
})


-- STOLEN FROM https://github.com/echasnovski/nvim/blob/d9b9ae2671ba47d3a36d3ed90b5de21cfaeb09b3/lua/ec/configs/nvim-treesitter.lua

-- Implement custom fold expression for markdown files. Should be defined after
-- `nvim-treesitter` initialization to avoid issues from lazy loading.
--
-- Designed to work with https://github.com/MDeiml/tree-sitter-markdown
-- General ideas:
-- - Requires 'folds.scm' query.
-- - Creates folds on headings (with fold level equal to heading level) and
--   code blocks.
-- - Code is basically a modification of 'nvim-treesitter/fold.lua'.
local query = require('nvim-treesitter.query')
local parsers = require('nvim-treesitter.parsers')
local ts_utils = require('nvim-treesitter.ts_utils')

local folds_levels = ts_utils.memoize_by_buf_tick(function(bufnr)
  local parser = parsers.get_parser(bufnr)

  if not (parser and query.has_folds('markdown')) then return {} end

  local levels = {}

  -- NOTE: don't use `_recursive` variant to fold only based on markdown itself
  local matches = query.get_capture_matches(bufnr, '@fold', 'folds')
  for _, m in pairs(matches) do
    local node = m.node
    local s_row, _, e_row, _ = node:range()
    local node_is_heading = node:type() == 'atx_heading' or node:type() == 'setext_heading'
    local node_is_code = node:type() == 'fenced_code_block'

    -- Process heading. Start fold at start line of heading with fold level
    -- equal to header level.
    if node_is_heading then
      for child in node:iter_children() do
        local _, _, level = string.find(child:type(), 'h([0-9]+)')
        if level ~= nil then
          levels[s_row] = ('>%s'):format(level)
          break
        end
      end
    end

    -- Process code block. Add fold level at start line and subtract at end.
    if node_is_code then
      levels[s_row] = 'a1'
      levels[e_row - 1] = 's1'
    end
  end

  return levels
end)

b4.markdown_foldexpr = function()
  local levels = folds_levels(vim.api.nvim_get_current_buf()) or {}

  return levels[vim.v.lnum - 1] or '='
end
