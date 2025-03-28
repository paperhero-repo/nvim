local M = {}

function M.setup()
	local map = vim.keymap.set

	-- 러더 키 설정
	vim.g.mapleader = " "

	-- 버퍼 관리
	map("n", "<leader>q", ":bdelete<CR>", { desc = "버퍼 닫기" }) -- 버퍼 삭제

	-- 시스템 클립보드
	map("v", "<leader>y", '"+y', { desc = "복사" }) -- 비주얼 모드에서 복사
	map("n", "<leader>y", '"+y', { desc = "복사" }) -- 라인 복사
	map("n", "<leader>Y", '"+Y', { desc = "복사" }) -- 라인 복사
	map("n", "<leader>p", '"+p', { desc = "붙여넣기" }) -- 붙여넣기
	map("n", "<leader>P", '"+P', { desc = "붙여넣기" }) -- 붙여넣기 (앞에)
end

return M
