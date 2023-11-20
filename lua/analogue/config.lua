-- TODO find resize event
-- TODO insert text into buffer


local M = {}

M.buf_opts = {
	buftype = 'nofile'
}

M.win_opts = {
	title = 'Sina',
	title_pos = 'center',
	-- focusable = false,
	relative = 'editor', -- win, editor, cursor, mouse
	style = 'minimal', -- removes row number
	row = 10,
	col = 80,
	width = 20,
	height = 10,
	border = { "/", "-", "\\", "|" } -- { ';' } -- {"", "", "", ">", "", "", "", "<"} - { ';' } 
}

M.command_opts = {
	nargs = '?'
}

return M

