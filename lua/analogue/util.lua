-- utility functions used across analogue

local M = {}

--Returns true if table contains a key/value with provided string value.
--If `isArray` is true table is considered an array so array items are checked. Otherwise it's considered an object-like table and its keys are checked.
---@param table table A table with keys of type string
---@param value string Value to check for its presence
---@param isArray boolean 
---@return boolean
function M.includes(table, value, isArray)
	local contains = false

	if isArray then
		for _, v in pairs(table) do
			if v == value then
				contains = true
				break
			end
		end
	else
		for k in pairs(table) do
			if k == value then
				contains = true
				break
			end
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

