local ok, dial = b4.pequire('dial.config')
if not ok then
  vim.notify('Could not load the "dial" plugin')
  return
end
local augend = require("dial.augend")
dial.augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.bool,
    augend.semver.alias.semver,
  },
})
