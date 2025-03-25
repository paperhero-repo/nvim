-- Lazy.vim 설치 로직
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("core.options").setup()
require("core.keymaps").setup()

if vim.g.neovide then
	require("core.neovide").setup()
end

-- 플러그인 모듈
local plugins = {
	require("plugins.__lazy"),
	require("plugins.__theme"),
	require("plugins.__nvim-tree"),
	require("plugins.__snipe"),
	require("plugins.__cmp"),
	require("plugins.__lsp_signature"),
	require("plugins.__lsp-config"),
	require("plugins.__telescope"),
	require("plugins.__nvim-lint"),
	require("plugins.__treesitter"),
	require("plugins.__conform"),
	require("plugins.__lualine"),
	require("plugins.__noice"),
	require("plugins.__hlchunk"),
	require("plugins.__which-key"),
	require("plugins.__gitsigns"),
	require("plugins.__vim-commentary"),
	require("plugins.__find-project-root"),
}

require("lazy").setup(plugins)
