-- ~/.config/nvim/lua/snippets/latex.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("spr", {
    t("\\sprechen{"), i(1, "Figur"), t("}{"), i(2, "Text"), t("}"),
  }),
}

