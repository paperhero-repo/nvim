local M = {}

function M.setup()
	-- 기본 VIM 설정 업데이트
	vim.diagnostic.config({
		update_in_insert = true,
		virtual_text = true,
		signs = true,
		underline = true,
		severity_sort = true,
		float = { border = "rounded" },
	})
	-- LSP 확장
	local capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities(),
		{
			textDocument = {
				foldingRange = { dynamicRegistration = false },
			},
		}
	)

	-- 진단 아이콘
	local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- 언어 서버 설정
	local servers = {
		gopls = {},
		ts_ls = {},
		pylsp = {
			settings = {
				pylsp = {
					plugins = {
						ruff = { enabled = true },
						pycodestyle = { enabled = false }, -- ruff와 중복 비활성화
						pylint = { enabled = true },
						flake8 = { enabled = false }, -- ruff로 대체
						jedi_completion = { fuzzy = true },
					},
				},
			},
		},
		html = { filetypes = { "html-lsp", "twing", "nbs" } },
		cssls = {},
		tailwindcss = {
			filetypes = {
				"html",
				"javascriptreact",
				"typescriptreact",
				"vue",
				"svelte",
				"twing",
			},
		},
		languageserver = {
			formatter = {
				ignoreMultilineInstructions = true,
			},
		},
		dockerls = {},
		docker_compose_language_service = {},
		sqlls = {},
		jsonls = {},
		yamlls = {},
		lua_ls = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					diagnostics = {
						globals = { "vim" },
						disable = { "missing-fields", "lowercase-global" },
					},
				},
			},
		},
	}

	-- Mason 설정
	require("mason").setup({
		ui = { border = "rounded" },
		max_concurrent_installers = 4,
	})

	require("mason-tool-installer").setup({
		ensure_installed = {
			"gopls",
			"ts_ls",
			"pylsp",
			"html-lsp",
			"tailwindcss-language-server",
			"lua-language-server",
			"dockerls",
			"docker-compose-language-service",
		},
		auto_update = true,
		run_on_start = true,
	})

	-- 언어 서버 자동 설정
	local lspconfig = require("lspconfig")
	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = capabilities
				-- 안전한 설정을 위한 pcall 사용
				local ok, msg = pcall(function()
					lspconfig[server_name].setup(server)
				end)
				if not ok then
					vim.notify("LSP 설정 실패: " .. server_name .. "\n" .. msg, vim.log.levels.ERROR)
				end
			end,
		},
	})

	-- LSP 연결 시 키매핑 설정
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			local bufnr = event.buf

			-- 실시간 하이라이트 성능 개선
			if client and client.supports_method("textDocument/documentHighlight") then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					callback = function()
						vim.schedule(vim.lsp.buf.document_highlight)
					end,
					desc = "LSP Document Highlight",
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					callback = vim.lsp.buf.clear_references,
					desc = "LSP Clear References",
				})
			end

			local map = vim.keymap.set
			-- LSP 기본 기능
			map("n", "gd", function()
				require("telescope.builtin").lsp_definitions()
			end, { desc = "정의로 이동" })

			map("n", "gr", function()
				require("telescope.builtin").lsp_references()
			end, { desc = "참조 검색" })

			map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "심볼 이름 변경" })
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "코드 작업 실행" }) -- ※ 모드 수정
			map("n", "gD", vim.lsp.buf.declaration, { desc = "선언부 이동" })

			-- Telescope 기능
			local builtin = require("telescope.builtin")
			map("n", "<leader>sf", builtin.find_files, { desc = "파일 검색" })
			map("n", "<leader>sd", builtin.diagnostics, { desc = "진단 정보 검색" })
			map("n", "<leader>sw", builtin.grep_string, { desc = "현재 단어 검색" })

			map("n", "<leader>sg", builtin.live_grep, { desc = "라이브 텍스트 검색" })
			map("n", "K", vim.lsp.buf.hover, { desc = "문서 피드백 보기" })
			map("n", "<leader>li", vim.lsp.buf.implementation, { desc = "구현체 이동" })

			map("n", "<leader>rr", function()
				vim.lsp.buf.code_action({ context = { only = { "refactor" } } })
			end, { desc = "리팩토링 작업" })
		end,
	})
end

return M
