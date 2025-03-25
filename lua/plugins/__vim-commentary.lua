return {
	"tpope/vim-commentary",
	config = function()
		vim.api.nvim_set_keymap("n", "<leader>/", "gcc", { desc = "코멘트", noremap = false })
		vim.api.nvim_set_keymap("v", "<leader>/", "gc", { desc = "코멘트", noremap = false })
	end,
}
