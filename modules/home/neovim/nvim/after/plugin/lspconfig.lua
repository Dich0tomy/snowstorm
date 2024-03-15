local neodev_ok, neodev = b4.pequire("neodev")
neodev.setup({
  experimental = {
    pathStrict = true,
  },
  library = {
    runtime = '~/Executable/storage/nvim-linux64/share/nvim/runtime',
  },
})

if not neodev_ok then
  vim.notify('Could not load the "neodev" plugin')
  return
end

local lsp_ok, lsp = b4.pequire('lspconfig')

if not lsp_ok then
  vim.notify('Could not load the "lsp" plugin')
  return
end

local custom_on_attach =  function(client, bufnr)
  local wk_ok, wk = b4.pequire('which-key')
  if wk_ok then
    local lsp_mappings = {
      name = 'LSP',
      ['<space>'] = {
        name = 'Meta',
        i = { '<cmd>LspInfo<cr>', 'Info' },
        l = { '<cmd>LspLog<cr>', 'Log' },
        r = { '<cmd>LspRestart<cr>', 'Restart' },
        s = { '<cmd>LspStart<cr>', 'Start' },
        S = { '<cmd>LspStop<cr>', 'Stop' }
      },
      c = {
        name = 'Calls',
        i = { '<cmd>Telescope lsp_incoming_calls<cr>', 'Incoming'},
        o = { '<cmd>Telescope lsp_outgoing_calls<cr>', 'Outgoing'},
      },
      f = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format' },
      R = { '<cmd>Telescope lsp_references<cr>', 'References' },
      d = { '<cmd>Telescope lsp_definitions<cr>', 'Definitions' },
      D = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'Diagnostics float' },
      i = { '<cmd>lua vim.lsp.inlay_hint.enable(vim.fn.bufnr(), not vim.lsp.inlay_hint.is_enabled(vim.fn.bufnr()))<cr>', 'Toggle inlay hint for buffer' },
      s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Local symbols' },
      S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Symbols' },
      l = { '<cmd>lua require "lsp_lines".toggle()<cr>', 'Toggle lsp_lines' },
      r = { function() vim.lsp.buf.rename() end, 'Toggle lsp_lines' },
      v = {
        function()
          local opts = {
            prefix = '◉ '
          }

          local virtual_text_enabled = vim.diagnostic.config().virtual_text

          vim.diagnostic.config({
            virtual_text = (not virtual_text_enabled) and opts or false
          })
        end,
        'Toggle virtual_text',
      }
    }

    wk.register(
      {
        l = lsp_mappings,
      },
      { prefix = '<leader>' }
    )

    wk.register(
      {
        [']d'] =  { vim.diagnostic.goto_prev, 'Goto next diag' },
        ['[d'] =  { vim.diagnostic.goto_next, 'Goto prev diag' },
        g = {
          d = { vim.lsp.buf.definition, 'Definition' },
          i = { vim.lsp.buf.implementation, 'Implementation' }
        }
      },
      { prefix = '' }
    )

    vim.keymap.set({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action, { desc = "Code actions" })
    vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
    vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
    vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
    vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')

    vim.api.nvim_create_autocmd(
      'BufWritePost',
      {
        callback = function ()
          if not vim.tbl_isempty(vim.lsp.get_active_clients()) and vim.b.format_on_save then
            vim.lsp.buf.format()
            vim.cmd.write();
          end
        end
      }
    )
  end
end

local server_caps = vim.lsp.protocol.make_client_capabilities()
local caps = require('cmp_nvim_lsp').default_capabilities(server_caps)
caps.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local default_config = {
  single_file_support = true,
  capabilities = caps,
  on_attach = custom_on_attach
}

local clangd_config = {
  single_file_support = true,
  capabilities = caps,
  on_attach = custom_on_attach,
  on_init = function(c, b)
    require("clangd_extensions.config").setup({
      extensions = {
        inlay_hints = {
          show_parameter_hints = false,
          other_hints_prefix = ': ',
        }
      }
    })
  end
}

local clangd_command = {
  (os.getenv('CLANGD_PATH') or 'clangd'),
  '--background-index',
  '--clang-tidy',
  '--completion-style=detailed',
  '--header-insertion=iwyu',
  '--header-insertion-decorators',
  '--all-scopes-completion',
  '--enable-config',
  '--pch-storage=disk',
}

local gcc_path = os.getenv('GCC_PATH')
if gcc_path and string.len(gcc_path) > 0 then
  table.insert(clangd_command, ('--query-driver=%s'):format(gcc_path));
end

lsp.clangd.setup(
  vim.tbl_extend('keep', clangd_config, {
    cmd = clangd_command,
 })
)

local sumneko_lua_settings = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.stdpath('data') .. "/site/pack/packer/opt/emmylua-nvim",
          vim.fn.stdpath('config'),
        },
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
    },
  }
}

lsp.lua_ls.setup(
  vim.tbl_deep_extend('keep', sumneko_lua_settings, default_config)
)

lsp.hls.setup(default_config)
lsp.tsserver.setup(default_config)
lsp.rust_analyzer.setup(default_config)
lsp.kotlin_language_server.setup(default_config)
lsp.neocmake.setup(default_config)

lsp.ruff_lsp.setup(default_config)
lsp.pyright.setup(default_config)

vim.diagnostic.config {
  update_in_insert = false,
  virtual_text = false,
  underline = true
}
