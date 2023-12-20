local a = vim.api
local config = require('analogue.config')

local M = {}
M._module = {}

local function reset_command()
	-- local commands = {
	-- 	["AnalogueRestore"] = {
	-- 		["name"] = "AnalogueRestore",
	-- 		["opts"] = {
	-- 			nargs = 0
	-- 		},
	-- 		["execute"] = function(win)
	-- 			a.nvim_win_set_config(win, {
	-- 				relative = 'editor',
	-- 				row = vim.o.lines - config.constants.height,
	-- 				col = vim.o.columns - config.constants.width,
	-- 			})
	-- 		end
	-- 	}
	-- }
	a.nvim_create_user_command(
		'AnalogueReset',
		function()
			a.nvim_win_set_config(M._module.win, {
				relative = 'editor',
				row = vim.o.lines - config.constants.height,
				col = vim.o.columns - config.constants.width,
			})
		end,
		{
			nargs = 0
		}
	)
end

local function close_command()
	a.nvim_create_user_command(
		'AnalogueClose',
		function()
			M._module.timer:stop()
			a.nvim_win_close(M._module.win, true)
		end,
		{
			nargs = 0
		}
	)
end

local function open_command(callback)
	a.nvim_create_user_command(
		'AnalogueOpen',
		function()
			M._module.open_callback()
		end,
		{
			nargs = 0
		}
	)
end

function M.refresh_cache(props)
	M._module.win = props.win
	M._module.timer = props.timer
end

function M.register_commands(props)
	M._module = {
		win = props.win,
		timer = props.timer,
		open_callback = props.open_callback
	}
	reset_command()
	close_command()
	open_command()
end

return M

