
local ok, diffview = b4.pequire('diffview')


if not ok then
  vim.notify('Could not load the "diffview" plugin')
  return
end

diffview.setup({
  diff_binaries = false,
  enhanced_diff_hl = true,
  git_cmd = { "git" },
  use_icons = true,
  show_help_hints = false,
  icons = {
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  view = {
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
    },
  },
  file_panel = {
    listing_style = "tree",
    tree_options = {
      flatten_dirs = true,
      folder_statuses = "only_folded",
    },
    win_config = {
      position = "left",
      width = 35,
    },
  },
  file_history_panel = {
    log_options = {
      git = {
        single_file = {
          diff_merges = "combined",
        },
      },
      multi_file = {
        diff_merges = "first-parent",
      },
    },
    win_config = {
      position = "bottom",
      height = 16,
    },
  },
  commit_log_panel = {
    win_config = {},
  },
  default_args = {
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {
    ---@param view StandardView
    view_opened = function(view)
      -- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
      -- the right.
      local function post_layout()
        utils.tbl_ensure(view, "winopts.diff2.a")
        utils.tbl_ensure(view, "winopts.diff2.b")
        view.winopts.diff2.a = utils.tbl_union_extend(view.winopts.diff2.a, {
          winhl = {
            "DiffChange:DiffAddAsDelete",
            "DiffText:DiffDeleteText",
          },
        })
        view.winopts.diff2.b = utils.tbl_union_extend(view.winopts.diff2.b, {
          winhl = {
            "DiffChange:DiffAdd",
            "DiffText:DiffAddText",
          },
        })
      end

      view.emitter:on("post_layout", post_layout)
      post_layout()
    end,
  }
})
