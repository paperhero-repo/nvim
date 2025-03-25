local M = {}
function M.setup()
  local conform = require('conform')
  conform.setup({
    formatters_by_ft = {
      lua = { 'stylua' },
    },
    format_on_save = {
      timeout_ms = 2000,
      lsp_fallback = true,
    },
  })
end

return M
