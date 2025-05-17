-- Datei: lua/plugins/colorizer.lua
return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    user_default_options = {
      RGB = true,        -- #RGB hex
      RRGGBB = true,     -- #RRGGBB hex
      names = false,     -- "blue", "red", etc.
      css = true,        -- Enable all CSS features: rgb() hex() hsl() etc.
      css_fn = true,     -- Enable functions like rgba(), hsl()
      tailwind = true,   -- Tailwind classes preview (e.g. bg-orange-500)
      mode = "background", -- Highlight mode: background | foreground | virtualtext
    },
  },
}

