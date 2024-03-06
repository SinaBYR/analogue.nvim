local a = vim.api
local config = require('analogue.config')

---@class M
---@field register_commands function as the name implies it registers custom commands and makes them available
---@field refresh_cache function it updates values of properties in `_module` table
---@field _module _Module

---@class _Module
---@field win? integer id of the window analogue is loaded in
---@field timer? uv_timer_t interval timer instance initialized on Analogue startup
---@field open_callback? function callback function which is called on Analogue startup (initializes window, buffer, timer and refreshes command module cache)

---@class M
local M = {}

M._module = {}

-- Creates `:AnalogueReset` custom command.
---@return nil
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
			M._module.open_callback()
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
---@field win integer id of the window
---@field timer uv_timer_t interval timer instance
---@field open_callback function callback function which is called on Analogue startup

-- Registers custom commands after initialization of Analogue.
--- @param props RegisterCommandsProps
--- @return nil
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

