local M = {}

local width = 17
local height = 11

---@param pos string
---@return table
function M.get_win_position(pos)
	if pos == "bottom-right" then
		return {
			row = vim.o.lines - height,
			col = vim.o.columns - width,
		}
	elseif pos == "bottom-left" then
		return {
			row = vim.o.lines - height,
			col = 1,
		}
	elseif pos == "top-right" then
		return {
			row = 1,
			col = vim.o.columns - width,
		}
	elseif pos == "top-left" then
		return {
			row = 1,
			col = 1,
		}
	else -- defaults to bottom-right
		return {
			row = vim.o.lines - height,
			col = vim.o.columns - width,
		}
	end
end

M.win_fixed_positions_keys = {
	"bottom-right",
	"bottom-left",
	"top-right",
	"top-left",
}

M.constants = {
	width = width,
	height = height
}

M.buf_opts = {
	buftype = 'nofile'
}

M.win_opts = {
	title = 'Analogue',
	title_pos = 'center',
	focusable = false,
	relative = 'editor', -- win, editor, cursor, mouse
	style = 'minimal', -- removes row number
	row = vim.o.lines - height,
	col = vim.o.columns - width,
	width = width,
	height = height,
	border = 'rounded', -- {'●'}, -- {"", "", "", ">", "", "", "", "<"} -- { "/", "-", "\\", "|" } -- { ';' } --  { ';' },
}

M.command_opts = {
	nargs = '?'
}

return M

