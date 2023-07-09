local ok, _ = b4.pequire('b4mbus.plugins.lazy_bootstrap')

if not ok then
  vim.notify([[Could not find and bootstrap lazy. Plugins can't be loaded]])
  return
end

require('lazy').setup(
  {
    {
      'folke/tokyonight.nvim',
      lazy = false,
      config = function()
        require('tokyonight').setup({
          on_highlights = function(hls)
            hls.CursorLine = {
              bg = '#000000',
            }
            hls.TelescopeNormal = {
              bg = '#000000',
            }
            hls.TelescopePromptNormal = {
              fg = '#BBBBBB',
              -- bg = '#444444',
            }
            hls.TelescopeBorder = {
              fg = '#8b008b',
            }
            hls.NormalNC = { }
            hls.CursorLineNr = {
              fg = '#ffffff',
              bold = true
            }
            hls.WinSeparator = {
              fg = '#8b008b',
              bold = true
            }
            hls.YankPost = {
              bg = '#15343c',
            }
          end
        })

        vim.cmd.colorscheme('tokyonight-night')
      end
    },
    {
      'Vigemus/iron.nvim',
      ft = 'BufRead'
    },
    {

      "fdschmidt93/telescope-egrepify.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
      'guns/vim-sexp',
      ft = 'fennel',
      init = function()
        vim.g.sexp_filetypes = 'scheme,lisp,fennel'
      end
    },
    {
      'jose-elias-alvarez/null-ls.nvim',
      event = 'BufRead',
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.fnlfmt
          },
        })
      end
    },
    {
      'vhyrro/hologram.nvim',
      config = function ()
        require('hologram').setup({
          auto_display = true
        })
      end
    },
    {
      'DNLHC/glance.nvim',
      lazy = false,
      config = function()
        local glance = require('glance')
        local actions = glance.actions

        glance.setup({
          height = 18, -- Height of the window
          zindex = 45,

          -- By default glance will open preview "embedded" within your active window
          -- when `detached` is enabled, glance will render above all existing windows
          -- and won't be restiricted by the width of your active window
          detached = true,

          -- Or use a function to enable `detached` only when the active window is too small
          -- (default behavior)
          detached = function(winid)
            return vim.api.nvim_win_get_width(winid) < 100
          end,

          preview_win_opts = { -- Configure preview window options
            cursorline = true,
            number = true,
            wrap = true,
          },
          border = {
            enable = false, -- Show window borders. Only horizontal borders allowed
            top_char = '―',
            bottom_char = '―',
          },
          list = {
            position = 'right', -- Position of the list window 'left'|'right'
            width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
          },
          theme = { -- This feature might not work properly in nvim-0.7.2
            enable = true, -- Will generate colors for the plugin based on your current colorscheme
            mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
          },
          mappings = {
            list = {
              ['j'] = actions.next, -- Bring the cursor to the next item in the list
              ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
              ['<Down>'] = actions.next,
              ['<Up>'] = actions.previous,
              ['<Tab>'] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
              ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
              ['<C-u>'] = actions.preview_scroll_win(5),
              ['<C-d>'] = actions.preview_scroll_win(-5),
              ['v'] = actions.jump_vsplit,
              ['s'] = actions.jump_split,
              ['t'] = actions.jump_tab,
              ['<CR>'] = actions.jump,
              ['o'] = actions.jump,
              ['l'] = actions.enter_win('preview'), -- Focus preview window
              ['q'] = actions.close,
              ['Q'] = actions.close,
              ['<Esc>'] = actions.close,
              -- ['<Esc>'] = false -- disable a mapping
            },
            preview = {
              ['q'] = actions.close,
              ['<Tab>'] = actions.next_location,
              ['<S-Tab>'] = actions.previous_location,
              ['l'] = actions.enter_win('list'), -- Focus list window
            },
          },
          hooks = {},
          folds = {
            fold_closed = '',
            fold_open = '',
            folded = true, -- Automatically fold list on startup
          },
          indent_lines = {
            enable = true,
            icon = '│',
          },
          winbar = {
            enable = true, -- Available strating from nvim-0.8+
          },
        })

      end
    },
    --[[ {
      'JosefLitos/reform.nvim',
      event = 'VeryLazy',
      build = 'make',
      config = true
    }, ]]
    -- {
    --   'sunjon/Shade.nvim',
    --   event = 'BufLeave',
    --   config = function()
    --     local shade = require 'shade'
    --     shade.setup({
    --       overlay_opacity = 60,
    --       opacity_step = 1,
    --     })
    --   end
    -- },
    {
      "nvim-neorg/neorg",
      build = ":Neorg sync-parsers",
      cmd = 'Neorg',
      ft = 'norg',
      event = 'BufRead',
      opts = {
        load = {
          ["core.defaults"] = {},
          ["core.looking-glass"] = {},
          ["core.concealer"] = {},
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = {
              extensions = "all",
            },
          },
          ["core.highlights"] = {
            config = {
              highlights = {
                modifiers = { escape = "+@spell" },
              }
            },
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/Znanie/Notes",
                campfire = "~/Znanie/Campfire",
                projects = "~/Znanie/Projects",
                languages = "~/Znanie/Languages",
                cpplangnet = "~/Znanie/CppLangNet",
                miceless = "~/Znanie/Miceless",
                trading = "~/Znanie/Trading",
              },
            },
          },
          ["core.esupports.metagen"] = {
            config = {
              type = 'auto',
              template = {
                { 'title', '' },
                { 'description', '' },
                { 'authors', 'B4mbus (Daniel Zaradny)' },
                { 'categories', 'notes' },
                { 'created', function() return os.date('%Y-%m-%d') end },
                { 'updated', function() return os.date('%Y-%m-%d') end },
                { 'version', '0.1.0' },
              }
            }
          },
        },
      },
      dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    --[[ {
      dir = '~/dev/projects/terminator.nvim',
      event = 'InsertEnter',
      config = function()
        local t = require('terminator')
        t.setup()
      end
    }, ]]
    {
      'rcarriga/nvim-notify',
      lazy = false,
      dependencies = {
        'nvim-telescope/telescope.nvim'
      },
      init = function()
        local notify = require('notify')

        notify.setup({
          timeout = 1000,
          stages = "slide",
          top_down = false,
          background_colour = "NormalFloat",

          max_width = function()
            return math.floor(vim.o.columns * 0.8)
          end,
          max_height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
          render = function(...)
            local notif = select(2, ...)
            local style = notif.title[1] == "" and "minimal" or "default"
            require("notify.render")[style](...)
          end,
        })
        vim.notify = notify

        local tok, telescope = b4.pequire('telescope')
        if tok then telescope.load_extension('notify') end
      end
    },
    'ggandor/leap.nvim',
    'ggandor/flit.nvim',
    'folke/todo-comments.nvim',
    {
      'NvChad/nvim-colorizer.lua',
      event = 'ColorsCheme',
      config = function()
        require('colorizer').setup({
          user_default_options = {
            RGB = false, -- #RGB hex codes
            RRGGBB = false, -- #RRGGBB hex codes
            names = false, -- "Name" codes like Blue or blue
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            AARRGGBB = false, -- 0xAARRGGBB hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            mode = "background", -- Set the display mode.
            virtualtext = "■",
          },
        })
      end
    },
    'j-hui/fidget.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle'
    },
    {
      'nvim-neotest/neotest',
      lazy = false,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
      }
    },
    {
      'monaqa/dial.nvim',
      keys = {
        { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
        { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" }
      }
    },
    -- 'NoahTheDuke/vim-just',
    'JoosepAlviste/nvim-ts-context-commentstring',
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      lazy = false
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      event = 'BufRead',
      config = function()
        require 'treesitter-context'.setup{
          enable = true,
          max_lines = 0,
          min_window_height = 0,
          line_numbers = true,
          multiline_threshold = 20,
          trim_scope = 'outer',
          mode = 'cursor',
          separator = nil,
          zindex = 20, -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        }
      end
    },
    'windwp/nvim-ts-autotag',
    {
      'danymat/neogen',
      dependencies = 'nvim-treesitter/nvim-treesitter',
    },
    {
      'tiagovla/scope.nvim',
      lazy = false,
    },
    {
      'tiagovla/buffercd.nvim',
      lazy = false,
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      event = { 'BufEnter', 'BufNewFile' }
    },
    {
      'lewis6991/gitsigns.nvim',
      event = 'BufRead'
    },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
    },
    {
      'numToStr/Comment.nvim',
      keys = { 'gc', 'gcc', 'gbc' },
      dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
    {
      'nvim-lualine/lualine.nvim',
      config = function()
        -- Eviline config for lualine

        -- Author: shadmansaleh
        --
        -- Credit: glepnir
        local lualine = require('lualine')

        -- Color table for highlights
        -- stylua: ignore
        local colors = {
          bg = '#202328',
          fg = '#bbc2cf',
          yellow = '#ECBE7B',
          cyan = '#008080',
          darkblue = '#5a8caf ',
          green = '#98be65',
          orange = '#FF8800',
          violet = '#a9a1e1',
          magenta = '#c678dd',
          blue = '#41a6b5',
          red = '#ec5f67',
        }

        local conditions = {
          buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
          hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
          check_git_workspace = function()
            local filepath = vim.fn.expand('%:p:h')
            local gitdir = vim.fn.finddir('.git', filepath .. ';')
            return gitdir and #gitdir > 0 and #gitdir < #filepath
          end,
        }

        -- Config
        local config = {
          options = {
            component_separators = '',
            section_separators = '',
            theme = 'iceberg_dark',
          },
          sections = {
            lualine_a = {}, lualine_b = {}, lualine_y = {},
            lualine_z = {}, lualine_c = {}, lualine_x = {},
          },
          inactive_sections = {
            lualine_a = {}, lualine_b = {}, lualine_y = {},
            lualine_z = {}, lualine_c = {}, lualine_x = {},
          },
        }

        local function ins_left(component) table.insert(config.sections.lualine_c, component) end

        local function ins_right(component) table.insert(config.sections.lualine_x, component) end

        ins_left {
          function() return '▊' end,
          color = { fg = colors.blue }, -- Sets highlighting of component
          padding = { left = 0, right = 1 }, -- We don't need space before this
        }

        ins_left {
          function() return 'λ' end,
          color = function()
            local mode_color = {
              n = colors.red,
              i = colors.green,
              v = colors.blue,
              [''] = colors.blue,
              V = colors.blue,
              c = colors.magenta,
              no = colors.red,
              s = colors.orange,
              S = colors.orange,
              [''] = colors.orange,
              ic = colors.yellow,
              R = colors.violet,
              Rv = colors.violet,
              cv = colors.red,
              ce = colors.red,
              r = colors.cyan,
              rm = colors.cyan,
              ['r?'] = colors.cyan,
              ['!'] = colors.red,
              t = colors.red,
            }

            return { fg = mode_color[vim.fn.mode()] }
          end,
          padding = { right = 1 },
        }

        ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }
        ins_left { 'filename', cond = conditions.buffer_not_empty, color = { fg = colors.darkblue, gui = 'bold' } }

        ins_left { 'branch', icon = ' ', color = { fg = colors.violet, gui = 'bold' } }

        ins_left {
          'diff',
          -- Is it me or the symbol for modified us really weird
          symbols = { added = '+', modified = '~', removed = '-' },
          diff_color = {
            added = { fg = colors.green, gui = 'bold' },
            modified = { fg = colors.orange, gui = 'bold' },
            removed = { fg = colors.red, gui = 'bold' },
          },
          cond = conditions.hide_in_width,
        }

        ins_left { function() return '%=' end }

        ins_left {
          function()
            local msg = 'No Active Lsp'

            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()

            if next(clients) == nil then
              return msg
            end

            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
              end
            end

            return msg
          end,
          icon = '  LSP:',
          color = { fg = '#777777', gui = 'bold' },
        }

        ins_right { 'filesize', cond = conditions.buffer_not_empty, color = { fg = '#555555' } }
        ins_right { 'location', color = { fg = '#555555' } }

        ins_right {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = { error = '  ', warn = '  ', info = '  ' },
          diagnostics_color = {
            color_error = { fg = colors.red },
            color_warn = { fg = colors.yellow },
            color_info = { fg = colors.cyan },
          },
        }

        ins_right {
          'o:encoding', -- option component same as &encoding in viml
          fmt = string.upper, -- I'm not sure why it's upper case either ;)
          cond = conditions.hide_in_width,
          color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
          'fileformat',
          fmt = string.upper,
          icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
          color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
          function()
            return '▊'
          end,
          color = { fg = colors.blue },
          padding = { left = 1 },
        }

        -- Now don't forget to initialize lualine
        lualine.setup(config)
      end,
      lazy = false;
    },
    {
      'ray-x/lsp_signature.nvim',
      lazy = false
    },
    {
      'hrsh7th/nvim-cmp',
      lazy = false, --event = 'InsertEnter',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip'
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'folke/neodev.nvim',
    {
      'neovim/nvim-lspconfig',
      event = 'BufReadPre'
    },
    { 'folke/which-key.nvim', lazy = false },
    {
      'mizlan/iswap.nvim',
      event = 'BufRead'
    },
    'gbprod/stay-in-place.nvim',
    'johmsalas/text-case.nvim',
    {
      'sindrets/diffview.nvim',
      cmd = {
        'DiffviewOpen',
        'DiffviewFileHistory'
      }
    },
    {
      'L3MON4D3/luasnip',
      event = 'InsertEnter'
    },
    {
      'stevearc/oil.nvim',
      lazy = false,
      config = function()
        local oil = require('oil')

        oil.setup({
          columns = {
            'icon',
          },
          keymaps = {
            ['g?'] = 'actions.show_help',
            ['<CR>'] = 'actions.select',
            ['<C-s>'] = 'actions.select_vsplit',
            ['<C-h>'] = 'actions.select_split',
            ['<C-t>'] = 'actions.select_tab',
            ['<C-p>'] = 'actions.preview',
            ['<C-c>'] = 'actions.close',
            ['<C-l>'] = 'actions.refresh',
            ['-'] = 'actions.parent',
            ['_'] = 'actions.open_cwd',
            ['`'] = 'actions.cd',
            ['~'] = 'actions.tcd',
            ['g.'] = 'actions.toggle_hidden',
            ['q'] = 'actions.close',
          },
        })

        vim.keymap.set(
          'n',
          '-',
          oil.open,
          { desc = 'Open parent directory' }
        )

        vim.keymap.set('n', '+', oil.open_float, { desc = 'Open parent directory float' })
      end
    },
    {
      'rktjmp/paperplanes.nvim'
    },
    {
      'rest-nvim/rest.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
      'Wansmer/treesj',
      dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    {
      'echasnovski/mini.nvim',
      event = 'BufRead'
    },
    'Pocco81/true-zen.nvim',
    'folke/noice.nvim',
    { 'potamides/pantran.nvim' },
    {
      'kevinhwang91/nvim-ufo',
      dependencies = 'kevinhwang91/promise-async',
    },
    -- Meta
    'ldelossa/litee.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'kevinhwang91/promise-async',
    'tpope/vim-repeat',
    'MunifTanjim/nui.nvim',

    { 'hrsh7th/cmp-nvim-lsp', },
    { 'hrsh7th/cmp-nvim-lua', },
    { 'hrsh7th/cmp-path', },
    { 'hrsh7th/cmp-buffer', },
    'bhurlow/vim-parinfer',
    {
      'vim-utils/vim-man',
      lazy = false
    },
    {
      'hrsh7th/nvim-insx',
      event = 'InsertEnter',
      config = function()
        local insx = require('insx')
        local esc = require('insx.helper.regex').esc

        for _, quote in ipairs({ '"', "'", "`" }) do
          insx.add(quote, require('insx.recipe.jump_next')({
            jump_pat = {
              [[\\\@<!\%#]] .. esc(quote) .. [[\zs]]
            },
          }))
          insx.add(quote, require('insx.recipe.auto_pair')({
            open = quote,
            close = quote,
            ignore_pat = [[\\\%#]],
          }))
          insx.add('<BS>', require('insx.recipe.delete_pair')({
            open_pat = esc(quote),
            close_pat = esc(quote),
          }))
        end

        -- pairs
        for open, close in pairs({
          ['('] = ')',
          ['['] = ']',
          ['{'] = '}',
          ['<'] = '>',
        }) do
          local oce = { open_pat = esc(open), close_pat = esc(close) }
          local oc = { open = open, close = close }

          insx.add(close, require('insx.recipe.jump_next')({
            jump_pat = {
              [[\%#]] .. esc(close) .. [[\zs]]
            },
          }))
          insx.add(open, require('insx.recipe.auto_pair')(oc))
          insx.add('<BS>', require('insx.recipe.delete_pair')(oce))
          insx.add('<Space>', require('insx.recipe.pair_spacing').increase(oce))
          insx.add('<BS>', require('insx.recipe.pair_spacing').decrease(oce))
          insx.add('<CR>', require('insx.recipe.fast_break')({
            open_pat = esc(open),
            close_pat = esc(close),
            split = true,
          }))
          insx.add('<C-l>', require('insx.recipe.fast_wrap')({
            close = close
          }))
        end
      end
    },
    'mfussenegger/nvim-dap',
    {
      'theHamsta/nvim-dap-virtual-text',
      setup = function()
        require("nvim-dap-virtual-text").setup()
      end
    },
    {
      'rcarriga/nvim-dap-ui',
      setup = function()
        require("dapui").setup()
      end
    },
    'rafamadriz/friendly-snippets',
    {
      'samjwill/nvim-unception',
      lazy = false
    },
    {
      'tpope/vim-dispatch',
      cmd = {
        'Make', 'Copen',
        'Dispatch', 'FocusDispatch',
        'Start',
      }
    },
    {
      'tpope/vim-eunuch',
      cmd = {
        'Remove', 'Delete',
        'Move', 'Rename',
        'Copy', 'Duplicate',
        'Chmod', 'Mkdir',
        'Cfind', 'Wall',
        'SudoWrite', 'SudoEdit'
      }
    },
    {
      'tpope/vim-fugitive',
      cmd = {
        'G',
        'Git',
        'GBrowse',
        'Gedit',
        'Gread',
        'Gwrite',
        'Ggrep',
        'Gdiffsplit',
        'GMove',
        'GDelete',
      }
    },
    {
      'tpope/vim-rhubarb',
      lazy = false
    },
    {
      'folke/paint.nvim',
      event = 'BufRead'
    },
    {
      'rafcamlet/nvim-luapad',
      cmd = { 'LuaRun', 'Luapad' }
    },
    {
      'ThePrimeagen/harpoon',
      lazy = false
    },
    'ThePrimeagen/git-worktree.nvim',
    {
      'tpope/vim-obsession',
      lazy = false
    },
    'p00f/clangd_extensions.nvim',
    'onsails/lspkind.nvim',
    {
      'andymass/vim-matchup',
      event = 'BufRead'
    },
    {
      'mattn/emmet-vim',
      event = 'BufRead'
    },
    'kyazdani42/nvim-web-devicons',
    { 'b4mbus/macro-status.nvim', dev = true }
  },
  {
    defaults = {
      lazy = true,
      version = nil,
    },
    install = {
      missing = true
    },
    performance = {
      cache = {
        enabled = true,
        path = vim.fn.stdpath("state") .. "/lazy/cache",
        disable_events = { "VimEnter", "BufReadPre" },
      },
      reset_packpath = true, -- reset the package path to improve startup time
      rtp = {
        reset = true,
        disabled_plugins = {
          '2html_plugin', 'getscript',
          'getscriptPlugin', 'gzip',
          'logipat', 'matchit',
          'loaded_remote_plugins',
          'loaded_tutor_mode_plugin',
          'rrhelper', 'spellfile_plugin',
          'tar', 'tarPlugin', 'vimball',
          'vimballPlugin', 'zip', 'zipPlugin',
          'matchparen', 'netrw'
        },
      },
    },
    readme = {
      root = vim.fn.stdpath("state") .. "/lazy/readme",
      files = { "README.md" },
      skip_if_doc_exists = true,
    },
  }
)
