local config = require('analogue.config')
local a = vim.api

local M = {}

function M.create_buffer(opts)
	local buf_opts = opts or config.buf_opts
	local buffer = a.nvim_create_buf(false, false)

	for opt, value in pairs(buf_opts) do
		a.nvim_buf_set_option(buffer, opt, value)
	end

	return buffer
end

function M.create_window(handle, opts)
	local win_opts = opts or config.win_opts
	local win = a.nvim_open_win(handle, true, win_opts)

	return win
end

return M

