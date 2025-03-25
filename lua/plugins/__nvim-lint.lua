return {
  "mfussenegger/nvim-lint",
  event = "BufWritePost",
  config = function()
    require("configs.__nvim-lint").setup()
  end
}
