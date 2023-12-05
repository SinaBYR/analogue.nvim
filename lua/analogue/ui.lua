local a = vim.api
local config = require('analogue.config')
local lookup = require('analogue.lookup').lookup

local M = {}

local function set_template(buf, template)
	a.nvim_buf_set_lines(buf, 0, -1, false, template)
end

local function update_template(buf, template)
	a.nvim_buf_set_lines(buf, 0, -1, false, {})
	a.nvim_buf_set_lines(buf, 0, -1, false, template)
end

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

local function create_buffer(opts)
	local buf_opts = opts or config.buf_opts
	local buffer = a.nvim_create_buf(false, false)

	for opt, value in pairs(buf_opts) do
		a.nvim_buf_set_option(buffer, opt, value)
	end

	return buffer
end

local function create_window(handle, opts)
	local win_opts = opts or config.win_opts
	local win = a.nvim_open_win(handle, true, win_opts)

	return win
end

local function set_schedule(buf)
	local template = get_template()
	update_template(buf, template)
	vim.defer_fn(set_schedule, 3 * 60 * 1000) -- interval at 3 minutes
end

local function close_window(win)
	a.nvim_win_close(win, true)
end

function M.initialize_clock(opts)
	local buf_opts = opts.buf_opts or config.buf_opts
	local win_opts = opts.win_opts or config.win_opts

	local buf = create_buffer(buf_opts)
	set_schedule(buf)
	-- local template = get_template()
	-- set_template(buf, template)
	local window = create_window(buf, win_opts)
end

return M

