local M = {}

function M.setup()
	vim.g.neovide_cursor_vfx_mode = "ripple"
	vim.g.neovide_cursor_smooth_blink = true
	vim.g.neovide_floating_shadow = false
end

return M
