local a = vim.api
local config = require('analogue.config')
local lookup = require('analogue.lookup').lookup
local util = require('analogue.util')
local cmd = require('analogue.command')

local M = {}
M._initial_opts = {}

local function get_template()
	local hour_index = tonumber(os.date("%I"))
	local min = tonumber(os.date("%M"))
	local aprox_index = min / 5
	local min_index

	local _, frac = math.modf(aprox_index)
	if frac >= 0.5 then
		min_index = math.ceil(aprox_index)
	else
		min_index = math.floor(aprox_index)
	end

	if min_index == 12 then
		min_index = 0
		if hour_index == 12 then
			hour_index = 1
		else
			hour_index = hour_index + 1
		end
	end

	return lookup[hour_index][min_index]
end

local function update_template(buf)
	local template = get_template()
	vim.schedule(function() a.nvim_buf_set_lines(buf, 0, -1, false, {}) end)
	vim.schedule(function() a.nvim_buf_set_lines(buf, 0, -1, false, template) end)
end

local function create_buffer()
	local buffer = a.nvim_create_buf(false, false)

	for opt, value in pairs(config.buf_opts) do
		a.nvim_buf_set_option(buffer, opt, value)
	end

	return buffer
end

local function create_window(handle, opts)
	local win_opts = config.win_opts

	if opts.hide_title then
		win_opts.title = nil
		win_opts.title_pos = nil
	end

	if opts.border then
		win_opts.border = opts.border
	end

	local win = a.nvim_open_win(handle, false, win_opts)

	return win
end

local function set_schedule(buf)
	return util.set_interval(2.5 * 60 * 1000, function() update_template(buf) end)
end

function M.initialize_clock(opts)
	M._initial_opts = opts
	local custom_win_opts = {
		hide_title = opts.hide_title,
		border = opts.border,
	}
	local auto_start = opts.auto_start

	if(auto_start == false) then
		cmd.register_commands({
			win = nil,
			timer = nil,
			open_callback = function()
				local buf = create_buffer()
				local win = create_window(buf, custom_win_opts)
				local timer = set_schedule(buf)

				cmd.refresh_cache({
					win = win,
					timer = timer
				})
			end
		})
	else
		local buf = create_buffer()
		local win = create_window(buf, custom_win_opts)
		local timer = set_schedule(buf)

		cmd.register_commands({
			win = win,
			timer = timer,
			open_callback = function()
				local buf = create_buffer()
				local win = create_window(buf, custom_win_opts)
				local timer = set_schedule(buf)

				cmd.refresh_cache({
					win = win,
					timer = timer
				})
			end
		})
	end
end

return M

