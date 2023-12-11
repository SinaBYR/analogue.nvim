local M = {}

local width = 16
local height = 11

M.constants = {
	width = width,
	height = height
}

M.buf_opts = {
	buftype = 'nofile'
}

M.win_opts = {
	-- focusable = false,
	-- title = 'Sina',
	-- title_pos = 'center',
	relative = 'editor', -- win, editor, cursor, mouse
	style = 'minimal', -- removes row number
	row = vim.o.lines - height,
	col = vim.o.columns - width,
	width = width,
	height = height,
	border = 'single', -- {'●'}, -- {"", "", "", ">", "", "", "", "<"} -- { "/", "-", "\\", "|" } -- { ';' } --  { ';' },
}

M.command_opts = {
	nargs = '?'
}

return M

