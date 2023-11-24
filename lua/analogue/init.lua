-- special file: can be loaded with require("analogue")
local M = {}
local util = require('analogue.util')
local config = require('analogue.config')
local a = vim.api
local ui = require('analogue.ui')


local function initialize(opts)
	local buf_opts = {}
	local buf = ui.create_buffer(buf_opts)
	local width = 18
	local height = 11
	local opts = {
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

	local win = ui.create_window(buf, opts)
end

initialize()

M.setup = function(opts)
	-- initialize()
end

return M

