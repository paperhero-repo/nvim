return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    --    "rcarriga/nvim-notify"
  },
  config = function()
    require("configs.__noice").setup()
  end
}
