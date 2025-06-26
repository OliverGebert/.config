local M = {}

---@param desc string
---@return table
function M.map_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

return M

