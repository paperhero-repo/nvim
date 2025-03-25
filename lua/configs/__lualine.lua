local M = {}

function M.setup()
	local lualine = require("lualine")

	local lsp_status = {
		"lsp_progress",
		separators = {
			component = " ",
			progress = " | ",
			percentage = { pre = "", post = "%% " },
			title = { pre = "", post = ": " },
			lsp_client_name = { pre = "[", post = "]" },
			spinner = { pre = "", post = "" },
			message = { commenced = "In Progress", completed = "Completed" },
		},
		display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
		timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
		spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
	}

	local lspName = function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_get_option_value("filetype", {})
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end

	lualine.setup({
		options = {
			theme = "auto",
			component_separators = { left = "•", right = "•" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "NvimTree", "alpha" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				"filename",
				lsp_status,
			},
			lualine_x = {
				"encoding",
				"fileformat",
				"filetype",
				lspName,
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		extensions = { "nvim-tree", "fugitive" },
	})
end

return M
