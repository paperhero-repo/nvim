local M = {}
function M.setup()
	require("noice").setup({
		cmdline = {
			enable = true,
			format = {

				conceal = false,
				cmdline = { pattern = "^:", icon = "󰘳 ", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "󰆕", lang = "bash" },
				lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
				help = { pattern = "^:%s*h%s+", icon = "󰞋" },
			},
		},
		popupmenu = {
			enabled = true,
		},
		views = {
			cmdline_popup = {
				position = {
					row = "50%", -- 세로 중앙
					col = "50%", -- 가로 중앙
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				size = {
					width = 60, -- 창 너비
					height = "auto",
				},
				win_options = {
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			cmdline_popupmenu = { -- 자동 완성 메뉴 스타일
				relative = "editor",
				position = {
					row = math.floor(vim.api.nvim_win_get_height(0) / 2) + 4, -- cmdline 아래로 조정
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "DiagnosticInfo",
						CursorLine = "Visual",
						PmenuSel = "WildMenu",
					},
				},
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			documentation = {
				view = "hover", -- LSP 문서 플로팅 창
				opts = {
					size = {
						width = "auto",
						height = "auto",
					},
					border = {
						style = "single",
						text = {
							top = " Documentation ",
						},
					},
				},
			},
		},
		presets = {
			lsp_doc_border = true, -- LSP 문서 테두리 활성화
			command_palette = true, -- Telescope 스타일 팔레트
		},
	})
end

return M
