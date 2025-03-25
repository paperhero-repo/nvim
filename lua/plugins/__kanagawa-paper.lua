return {
  'thesimonho/kanagawa-paper.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require("configs.__kanagawa-paper").setup()
  end
}
