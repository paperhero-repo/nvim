return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'arkav/lualine-lsp-progress'
  },
  config = function()
    require("configs.__lualine").setup()
  end
}
