local M = {}
function M.setup()
  require('lint').linters_by_ft = {
    python = { 'flake8', 'mypy' },
  }

  vim.api.nvim_create_autocmd({'BufWritePost'}, {
    callback = function ()
     require('lint').try_lint()
    end
  })
end
return M
