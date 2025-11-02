-- lazy.nvim
return {
    "sontungexpt/url-open",
    event = "VeryLazy",
    cmd = "URLOpenUnderCursor",
    config = function()
        local mapk = require("utils").mapk
        local status_ok, url_open = pcall(require, "url-open")
        if not status_ok then
            return
        end
        mapk('n', '<leader>ou', "<esc>:URLOpenUnderCursor<cr>", "open URL under cursor")
        url_open.setup ({})
    end,
}


