local a = vim.api
local config = require('analogue.config')
local util = require('analogue.util')

local M = {}

---@alias FixedPosition "bottom-right"|"bottom-left"|"top-right"|"top-left"

---@class AdjustedPosition
---@field x? number
---@field y? number

---@class _Module
---@field win? integer id of the window analogue is loaded in
---@field timer? uv_timer_t interval timer instance initialized on Analogue startup
---@field open_handler? function function called on Analogue startup (initializes window, buffer, timer and refreshes command module cache)
---@field fixed_position? FixedPosition fixed position of the clock
---@field adjusted_position? AdjustedPosition user-adjusted exact position of the clock
M._module = {}

-- Creates `:AnaloguePositionX {num}` custom command.
-- Argument `{num}` must be a number.
---@return nil
local function position_x_command()
	a.nvim_create_user_command(
		'AnaloguePositionX',
		function(props)
			local inputX = tonumber(props.args)
			if inputX == nil then
				a.nvim_err_writeln("Argument must be number")
			else
				local pos = config.get_win_position(M._module.fixed_position)
				M._module.adjusted_position.x = M._module.adjusted_position.x + inputX
				a.nvim_win_set_config(M._module.win, {
					relative = 'editor',
					row = pos.row,
					col = M._module.adjusted_position.x
				})
			end
		end,
		{
			nargs = 1
		}
	)
end

-- Creates `:AnaloguePosition {pos}` custom command.
-- Values for `{pos}` can be `bottom-right`, `bottom-left`, `top-right`, or `top-left`.
---@return nil
local function position_command()
	a.nvim_create_user_command(
		'AnaloguePosition',
		function(props)
			if util.includes(config.win_fixed_positions_keys, props.args, true) then
				local pos = config.get_win_position(props.args)
				M._module.fixed_position = props.args
				M._module.adjusted_position = { x = pos.col, y = pos.row }
				a.nvim_win_set_config(M._module.win, {
					relative = 'editor',
					row = pos.row,
					col = pos.col,
				})
			else
				a.nvim_err_writeln("Unknown position value")
			end
		end,
		{
			nargs = 1
		}
	)
end

-- Creates `:AnalogueReset` custom command.
---@return nil
local function reset_command()
	a.nvim_create_user_command(
		'AnalogueReset',
		function()
			local pos = config.get_win_position(M._module.fixed_position)
			a.nvim_win_set_config(M._module.win, {
				relative = 'editor',
				row = pos.row,
				col = M._module.adjusted_position.x
			})
		end,
		{
			nargs = 0
		}
	)
end

-- Creates `:AnalogueClose` custom command.
---@return nil
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

-- Creates `:AnalogueOpen` custom command.
---@return nil
local function open_command()
	a.nvim_create_user_command(
		'AnalogueOpen',
		function()
			M._module.open_handler()
		end,
		{
			nargs = 0
		}
	)
end

---@class RefreshCacheProps
---@field win integer new id of the window
---@field timer uv_timer_t new interval timer instance

-- Updates values of properties in `_module` table.
--- @param props RefreshCacheProps
--- @return nil
function M.refresh_cache(props)
	M._module.win = props.win
	M._module.timer = props.timer
end

---@class RegisterCommandsProps
---@field win? integer id of the window
---@field timer? uv_timer_t interval timer instance
---@field open_handler function function called on Analogue startup
---@field fixed_position FixedPosition fixed position of floating window

-- Registers custom commands after initialization of Analogue.
--- @param props RegisterCommandsProps
--- @return nil
function M.register_commands(props)
	M._module = {
		win = props.win,
		timer = props.timer,
		open_handler = props.open_handler,
		fixed_position = props.fixed_position,
		adjusted_position = {
			x = config.get_win_position(props.fixed_position).col,
			y = config.get_win_position(props.fixed_position).row,
		}
	}
	reset_command()
	close_command()
	open_command()
	position_command()
	position_x_command()
end

return M

