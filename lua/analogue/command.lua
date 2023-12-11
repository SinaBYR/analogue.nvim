local a = vim.api
local config = require('analogue.config')

local M = {}

function restore(win)
	a.nvim_create_user_command(
		'AnalogueRestore',
		function()
			a.nvim_win_set_config(win, {
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

function M.register_commands(win)
	restore(win)
end

return M

