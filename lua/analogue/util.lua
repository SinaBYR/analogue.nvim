-- utility functions used across analogue

local M = {}

function M.print_table(table)
	vim.print(table)
end

function M.buffer_to_string()
	local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
	return table.concat(content, "\n")
end

return M

