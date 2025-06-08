-- lua/config/env.lua
local M = {}

function M.load_env_file(path)
  local env_file = io.open(path, "r")
  if not env_file then
    vim.notify(".env file not found at " .. path, vim.log.levels.WARN)
    return
  end

  for line in env_file:lines() do
    local key, value = line:match("^%s*([%w_]+)%s*=%s*(.+)%s*$")
    if key and value then
      -- Nur setzen, wenn nicht bereits vorhanden
      if not os.getenv(key) then
        vim.fn.setenv(key, value)
      end
    end
  end
  env_file:close()
end

return M
