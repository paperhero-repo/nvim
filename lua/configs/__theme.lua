local M = {}

function M.setup()
	require("kanagawa-paper").setup({
		default_integrations = true,
	})
	vim.cmd.colorscheme("kanagawa-paper-canvas")
end

return M
