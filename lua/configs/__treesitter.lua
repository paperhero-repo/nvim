local M = {}
function M.setup()
  require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'lua', 'python', 'javascript', 'typescript', 'html', 'css', 'json', 'bash', 'vim'
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enbale = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
          },
        },
      },
  })
end
return M
