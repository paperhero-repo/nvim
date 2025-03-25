local M = {}
function M.setup()
	local nvimtree = require("nvim-tree")
	local utils = require("core.utils")
	nvimtree.setup({
		hijack_netrw = false,
		hijack_cursor = true,
		hijack_unnamed_buffer_when_opening = false,
		update_cwd = false,
		sync_root_with_cwd = false,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = false,
		},
		view = {
			float = {
				enable = true, -- 플로팅 창 활성화
				open_win_config = function()
					local _size = utils.get_screen_size()
					local _width = 40
					local _height = math.floor(_size.height * 0.8)
					return {
						relative = "editor",
						width = _width,
						height = _height,
						col = math.floor((_size.width - _width) / 2),
						row = math.floor((_size.height - _height) / 2),
						border = "rounded",
					}
				end,
			},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = true,
			debounce_delay = 50,
			severity = {
				min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},

		modified = {
			enable = true,
			show_on_dirs = true,
		},

		renderer = {
			add_trailing = false, -- 파일/폴더 이름 끝에 '/' 자동 추가 비활성화
			group_empty = false, -- 빈 폴더 그룹화 비활성화
			highlight_git = true, -- Git 상태(수정, 스테이징 등) 강조 활성화
			full_name = false, -- 전체 파일 경로 대신 이름만 표시
			highlight_opened_files = "icon", -- 열린 파일 아이콘 강조 (none/name/icon)
			root_folder_label = ":~", -- 루트 폴더 표시 형식 (false로 숨김 가능)
			indent_width = 2, -- 들여쓰기 너비 (기본 2칸)
			indent_markers = {
				enable = true, -- 들여쓰기 가이드 라인 활성화
				inline_arrows = true, -- 인라인 화살표 사용 (false: 블록 문자)
				icons = {
					corner = "└", -- 폴더 닫힘 시 코너 문자
					edge = "│", -- 세로 라인 문자
					item = "│", -- 파일 항목 라인 문자
					bottom = "─", -- 하단 라인 문자
					none = " ", -- 빈 공간 채움 문자
				},
			},
			icons = {
				webdev_colors = true, -- 웹 개발 파일 타입 색상 사용 (예: .html, .css)
				git_placement = "before", -- Git 아이콘 위치 (before/after)
				modified_placement = "after", -- 수정 표시 위치
				diagnostics_placement = "signcolumn", -- 진단 아이콘 위치
				bookmarks_placement = "signcolumn", -- 북마크 아이콘 위치

				show = { -- 표시할 요소
					file = true, -- 파일 아이콘
					folder = true, -- 폴더 아이콘
					folder_arrow = true, -- 폴더 화살표 (▶/▼)
					git = true, -- Git 상태
					modified = true, -- 수정 상태
					diagnostics = true, -- LSP 진단
					bookmarks = true, -- 북마크
				},

				glyphs = { -- 사용자 정의 아이콘
					bookmark = "", -- 북마크 아이콘 ()
					folder = { -- 폴더 아이콘 세트
						arrow_closed = "", -- 닫힌 폴더 화살표 (▶)
						arrow_open = "", -- 열린 폴더 화살표 (▼)
						default = "", -- 기본 폴더 아이콘
						open = "", -- 열린 폴더 아이콘
						empty = "", -- 빈 폴더
						empty_open = "", -- 열린 빈 폴더
						symlink = "", -- 심볼릭 링크 폴더
						symlink_open = "", -- 열린 심볼릭 링크
					},
					git = { -- Git 상태 아이콘
						unstaged = "", -- 스테이징 안됨 (●)
						staged = "✓", -- 스테이징 됨 (✓)
						unmerged = "", -- 충돌 상태 ()
						renamed = "➜", -- 이름 변경 (➜)
						untracked = "★", -- 추적되지 않음 (★)
						deleted = "", -- 삭제됨 ()
						ignored = "◌", -- 무시됨 (◌)
					},
				},
			},
		},

		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			local opts = function(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "<Esc>", api.tree.close, opts("Close floating tree"))
			vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
		end,
	})
	vim.keymap.set("n", "<leader>e", function()
		require("nvim-tree.api").tree.toggle()
	end, { desc = "파일탐색기" })

	vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { link = "FloatNormal" })
end

return M
