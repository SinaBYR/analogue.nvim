local M = {}

local width = 17
local height = 11

M.win_positions = {
	["bottom-right"] = {
		row = vim.o.lines - height,
		col = vim.o.columns - width,
	},
	["bottom-left"] = {
		row = vim.o.lines - height,
		col = 1,
	},
	["top-right"] = {
		row = 1,
		col = vim.o.columns - width,
	},
	["top-left"] = {
		row = 1,
		col = 1,
	}
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

