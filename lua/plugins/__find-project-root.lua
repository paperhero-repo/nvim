return {
	"paperhero-repo/find-project-root.nvim",
	config = function()
		require("find-project-root").setup()
		vim.keymap.set("n", "<leader>pr", "<cmd>FindProjectRoot<CR>", { desc = "Find Project Root" })
	end,
}
