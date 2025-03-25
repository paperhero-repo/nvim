local M = {}

function M.setup()
	require("snipe").setup({
		ui = {
			position = "cursor",
			open_win_override = {
				title = "Buffers",
				border = "rounded",
			},
			preselect_current = true,
			text_align = "right",
			title = "Buffers",
		},
		hints = {
			dictionary = "1234qwerasdfzxcv",
		},
		sort = "last",
	})

	-- Snipe
	vim.keymap.set("n", "<leader><leader>", function()
		local api = require("snipe")
		api.open_buffer_menu()
	end, { desc = "버퍼선택기" })
end

return M
