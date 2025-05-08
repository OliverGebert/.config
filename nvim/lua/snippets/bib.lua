local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Snippet für @book
  s("book", {
    t("@book{"), i(1, "key"), t({",", "  author = {"}), i(2, "Autor Name"), t({"},"}),
    t({"", "  title = {"}), i(3, "Titel des Buches"), t({"},"}),
    t({"", "  year = {"}), i(4, "2023"), t({"},"}),
    t({"", "  publisher = {"}), i(5, "Verlag"), t({"}", "}"}),
  }),

  -- Snippet für @online
  s("online", {
    t("@online{"), i(1, "key"), t({",", "  author = {"}), i(2, "Autor Name"), t({"},"}),
    t({"", "  title = {"}), i(3, "Titel der Webseite"), t({"},"}),
    t({"", "  year = {"}), i(4, "2023"), t({"},"}),
    t({"", "  url = {"}), i(5, "https://example.com"), t({"},"}),
    t({"", "  urldate = {"}), i(6, "2025-05-07"), t({"},"}),
    t({"", "  note = {"}), i(7, "Letzter Zugriff am 7. Mai 2025"), t({"}", "}"}),
  }),}

