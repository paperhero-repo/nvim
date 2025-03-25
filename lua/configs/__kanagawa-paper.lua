local M = {}
function M.setup()
  require("kanagawa-paper").setup({
    vim.cmd.colorscheme 'kanagawa-paper-ink'
  })
end

return M
