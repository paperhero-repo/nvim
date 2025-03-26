local M = {}

function M.setup()
  vim.g.neovide_cursor_vfx_mode = "ripple"
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_font_size = 18.0
  vim.g.neovide_multigrid = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_no_idle = true
  vim.g.neovide_vsync = true
end

return M
