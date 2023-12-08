-- special file: can be loaded with require("analogue")
local M = {}
local ui = require('analogue.ui')


M.setup = function(opts)
	ui.initialize_clock(opts)
end

return M

