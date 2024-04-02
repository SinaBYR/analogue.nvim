-- utility functions used across analogue

local M = {}

--Returns true if record contains a property with provided key
---@param record table A table with keys of type string
---@param key string Key to check for its presence
---@return boolean
function M.includes(record, key)
	local contains = false

	for k in pairs(record) do
		if k == key then
			contains = true
			break
		end
	end

	return contains
end

function M.print_table(table)
	vim.print(table)
end

function M.buffer_to_string()
	local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
	return table.concat(content, "\n")
end

function M.set_interval(interval, callback)
  local timer = vim.loop.new_timer()
  timer:start(0, interval, function ()
    callback()
  end)
  return timer
end

function M.clear_interval(timer)
  timer:stop()
  timer:close()
end

return M

