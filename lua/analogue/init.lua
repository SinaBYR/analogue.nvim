-- special file: can be loaded with require("analogue")
local M = {}
local ui = require('analogue.ui')


M.setup = function(opts)
	ui.initialize_clock(opts)
end

-- local co = coroutine.create(interval)
-- coroutine.resume(co)
-- vim.defer_fn(function() vim.g.timer_result = true end, 100)


return M

