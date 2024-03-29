vim.b.format_on_save = true

local ok, ls = pcall(require, "luasnip")
if not ok then return end

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

ls.add_snippets("cpp", {
  s("main", fmt(
    [=[
    auto main({}) -> int
    {{
      {}
    }}
    ]=],
    { c(1, { t(''), t('int argc. char** argv') }), i(0) })
  ),
  postfix('.as', {
    d(1, function(_, parent)
      return sn(
        1,
        fmt('static_cast<{}>(' .. parent.snippet.env.POSTFIX_MATCH .. ')', {
          i(1, 'int'),
        })
      )
    end)
  })
})
