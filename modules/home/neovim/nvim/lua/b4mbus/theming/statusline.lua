local fmt = string.format

local symbols = require('b4mbus.symbols')

local get_git_changed = function()
  return fmt(
    '%s%s %s%s %s%s',
    '%#GitAdded#', vim.b.gitsigns_status_dict.added,
    '%#GitChanged#', vim.b.gitsigns_status_dict.changed,
    '%#GitRemoved#', vim.b.gitsigns_status_dict.removed
  )
end

local get_git_dot = function()
  return fmt(
    '%s%s%s',
    '%#BoldWhite#',
    symbols.small_dot,
    '%#st_none#'
  )
end

local get_git_branch = function(head)
  return fmt(
    '%s#%s%s',
    '%#GitBranchSign#',
    '%#GitBranch#',
    head
  )
end

local get_git_status_sections = function(head)
  return get_git_changed(), get_git_dot(), get_git_branch(head)
end

local get_git_status = function()
	local branch = vim.b.gitsigns_status_dict or { head = '' }
	local head_empty = branch.head == ''

	if not head_empty then
    local changed, dot, branch = get_git_status_sections(branch.head)

		return fmt(
			'%s(%s %s %s%s)%s',
			'%#StatusLineBranchColor#',
      changed,
      dot,
			branch,
      '%#StatusLineBranchColor#',
      '%#st_none#'
		)
	else
		return ''
	end
end

local get_lsps_count = function(clients)
	local lsps_count = 0

	for _, client in pairs(clients) do
		if client.name ~= 'copilot' then
			lsps_count = lsps_count + 1
		end
	end

  return lsps_count
end

local valid_lsps_attached = function(clients)
	if next(clients) == nil then
		return false
	end

	local lsps_count = get_lsps_count(clients)

	if lsps_count == 0 then
		return false
	else
		return true
	end
end

local get_lsp_diagnostics = function()
  local vl = vim.lsp
	local buffer_clients = vl.buf_get_clients(0)
	if not valid_lsps_attached(buffer_clients) then
		return ''
	end

	local diagnostics = vim.diagnostic.get(0)
	local count = {0, 0, 0, 0}

	for _, diag in ipairs(diagnostics) do
		local sev = diag.severity
		count[sev] = (count[sev] + 1)
	end

	local severity = vim.diagnostic.severity
	return fmt(
		'%%#DiagnosticError#%s%%#st_none# %%#DiagnosticWarn#%s%%#st_none# %%#DiagnosticHint#%s%%#st_none#',
		count[severity.ERROR] or 0,
		count[severity.WARN] or 0,
		count[severity.HINT] or 0
	)
end

local get_file = function()
  local path = vim.fn.expand('%:p')

  if path:find('^term://') then
    path = path:sub(8, -1)
    local _, path_end_end = path:find('//')
    path = path:sub(path_end_end + 1, -1)

    local colon = path:find(':')
    local pid = path:sub(0, colon - 1)
    local prog = path:sub(colon + 1, -1)

	  return
	    '%#White#'
	    .. prog
      .. ' '
	    .. '%#Red#'
	    .. pid
  elseif path:find('^fugitive://') then
    local second = function(x, y) return y end

    -- TODO: handle the case for worktrees
    local _, path_end_end = path:find('.git//')
    path_end_end = path_end_end or second(path:find('.git/'))
    path = path:sub(path_end_end + 1, -1)

    local slash_pos = path:find('/')

    if not slash_pos then
      return fmt(
        '%s#%s%s',
        '%#GitBranchSign#',
        '%#GitBranch#',
        vim.fn['FugitiveStatusline']():sub(6,-3)
      )
    end

    local commit = path:sub(0, slash_pos - 1)
    local path = path:sub(slash_pos + 1, -1)

    local file_name = vim.fn.fnamemodify(path, ':t')
    local ok, Path = pcall(require, 'plenary.path')
    local file_tail = ok and Path:new(vim.fn.fnamemodify(path, ':h')):make_relative() or ''

    return
      '%#GitCommitStatuslineShort#'
      .. commit:sub(0, 7)
      .. '%#GitCommitStatusline#'
      .. commit:sub(8, -1)
      .. ' '
      .. '%#NiceGrey#'
      .. file_tail
      .. '/'
      .. '%#BoldBlue#'
      .. file_name
  end

	local file_readable = vim.fn.filereadable(path)
	local file_name = vim.fn.fnamemodify(path, ':t')
  local ok, Path = pcall(require, 'plenary.path')
	local file_tail = ok and Path:new(vim.fn.fnamemodify(path, ':h')):make_relative() or ''

	local format = '%%#NiceGrey#' .. file_tail .. '/' .. '%s' .. file_name .. '%%#st_none#'

	if file_readable == 0 then
		return fmt(format, '%#BoldRed#')
  else
		return fmt(format, '%#BoldWhite#')
	end
end

local get_macro_status = function()
  local o, m = pcall(require, 'macro-status')
  if o then
    return m.get_register_formatted()
  else
    return ''
  end
end

local get_noice_message = function(cap)
  local o, n = pcall(require, 'noice')
  if o then
    local msg = n.api.status.message.get()
    if msg then return msg:gsub('\n', ''):sub(1, cap) end
  else
    return ''
  end
end

-- DeeplStatus = ''
-- local function get_deepl_status()
--   LastTotal = 0
--   local hours_in_mins = tonumber(vim.fn.strftime('%H')) * 60
--   local mins = tonumber(vim.fn.strftime('%M'))
--   local total = hours_in_mins + mins
--
--   if total - LastTotal < 1 then
--     return
--   end
--
--   LastTotal = total
--
--   local o, Job = b4.pequire('plenary.job')
--   if o then
--     Job:new({
--       command = 'curl',
--       args = {
--         [[https://api-free.deepl.com/v2/usage]],
--         [[-H]],
--         [[Authorization: DeepL-Auth-Key ec900afb-ebf5-eec0-5056-e696544e4e39:fx]]
--       },
--       on_exit = function(j, return_val)
--         local result = j:result()
--         if next(result) ~= nil then
--           local character_count = result[1]:match('"character_count":(%d+)')
--           local character_limit = result[1]:match('"character_limit":(%d+)')
--
--           DeeplStatus = character_count .. '/' .. character_limit
--         end
--       end,
--     }):start()
--   end
-- end

StatuslineMod = {}

StatuslineMod.statusline = function()
  local obsession_status =
    vim.fn['ObsessionStatus'](
      '%#SessionActive#[{}]', -- using {} because obsession uses %s
      '%#SessionInactive#[{}]' -- using {} because obsession uses %s
    )

  return table.concat(
    {
      '',
      obsession_status and obsession_status:gsub('{}', symbols.null) or '',
      get_file(),
      get_macro_status(),
      get_git_status(),
      get_lsp_diagnostics(),
      ''
    },
    ' '
  ):gsub(' +', ' ') -- we change duplicate spaces into one space
end

-- vim.opt.statusline = '%{%v:lua.StatuslineMod.statusline()%}'
