-- Yoinked from https://www.reddit.com/r/neovim/comments/10fpqbp/gist_statuscolumn_separate_diagnostics_and/
-- and modified

local function get_sign_name(cur_sign)
  if (cur_sign == nil) then
    return nil
  end

  cur_sign = cur_sign[1]

  if (cur_sign == nil) then
    return nil
  end

  cur_sign = cur_sign.signs

  if (cur_sign == nil) then
    return nil
  end

  cur_sign = cur_sign[1]

  if (cur_sign == nil) then
    return nil
  end

  return cur_sign["name"]
end

local function mk_hl(group, sym)
  return table.concat({ "%#", group, "#", sym, "%*" })
end

local function get_name_from_group(bufnum, lnum, group)
  local cur_sign_tbl = vim.fn.sign_getplaced(bufnum, {
    group = group,
    lnum = lnum
  })

  return get_sign_name(cur_sign_tbl)
end

_G.get_statuscol_gitsign = function(bufnr, lnum)
  -- local gitsigns_bar = '▌'
  local gitsigns_bar = '🭳'

  local gitsigns_hl_pool = {
    GitSignsAdd          = "DiagnosticOk",
    GitSignsChange       = "DiagnosticWarn",
    GitSignsChangedelete = "DiagnosticWarn",
    GitSignsDelete       = "DiagnosticError",
    GitSignsTopdelete    = "DiagnosticError",
    GitSignsUntracked    = "NonText",
  }
  local cur_sign_nm = get_name_from_group(bufnr, lnum, "gitsigns_vimfn_signs_")

  if cur_sign_nm ~= nil then
    return mk_hl(gitsigns_hl_pool[cur_sign_nm], gitsigns_bar)
  else
    return " "
  end
end

_G.get_statuscol_diag = function(bufnum, lnum)
  local diag_signs_icons = {
    DiagnosticSignError = "",
    DiagnosticSignWarn = "",
    DiagnosticSignInfo = "",
    DiagnosticSignHint = "",
    DiagnosticSignOk = ""
  }

  local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

  if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
    return mk_hl(cur_sign_nm, diag_signs_icons[cur_sign_nm])
  else
    return " "
  end
end

_G.get_statuscol_dap = function(bufnum, lnum)
  local dap_hl_pool = {
    DapBreakpoint = 'DiagnosticSignError',
    DapLogPoint = 'DiagnosticSignsError',
    DapBreakpointCondition = 'DiagnosticSignsError',
    DapBreakpointRejected = 'DiagnosticSignsError'
  }

  local dap_signs_icons = {
    DapBreakpoint  = "⬤ ",
    DapLogPoint  = "✎ ",
    DapBreakpointCondition  = "⦿",
    DapBreakpointRejected  = "⬟ "
  }

  local cur_sign_nm = get_name_from_group(bufnum, lnum, "*")

  if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "Dap") then
    return mk_hl(dap_hl_pool, dap_signs_icons[cur_sign_nm])
  else
    return " "
  end
end

_G.get_statuscol = function()
  local str_table = {}

  local parts = {
    ["diagnostics"] = "%{%v:lua.get_statuscol_diag(bufnr(), v:lnum)%}",
    ["dap"] = "%{%v:lua.get_statuscol_dap(bufnr(), v:lnum)%}",
    ["fold"] = "%C",
    ["gitsigns"] = "%{%v:lua.get_statuscol_gitsign(bufnr(), v:lnum)%}",
    ["num"] = "%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''}",
    ["sep"] = "%=",
    ["signcol"] = "%s",
    ["space"] = " "
  }

  local order = {
    "diagnostics",
    "sep",
    -- "num",
    "gitsigns",
    "fold",
    "dap",
  }

  for _, val in ipairs(order) do
    table.insert(str_table, parts[val])
  end

  return table.concat(str_table)
end

vim.opt.statuscolumn = '%!v:lua._G.get_statuscol()'
