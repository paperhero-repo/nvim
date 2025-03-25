local M = {}

function M.detect_project_root()
  local current_file = vim.fn.expand '%:p'
  if current_file == '' then
    current_file = vim.fn.getcwd()
  end

  -- 지원하는 프로젝트 마커 목록
  local markers = {
    '.git',
    'go.mod',       -- Go
    'pubspec.yaml', -- Flutter
    'package.json', -- SvelteKit/Node.js
    'svelte.config.js',
    'Cargo.toml',   -- Rust (추가 가능)
    'CMakeLists.txt',
    'mix.exs',
    'pyproject.toml',
  }

  local function find_root(path)
    local parent = vim.fn.fnamemodify(path, ':h')
    if parent == path then
      return nil -- Root 디렉토리에 도달
    end

    for _, marker in ipairs(markers) do
      local check_path = vim.fn.glob(path .. '/' .. marker)
      if check_path ~= '' then
        return path
      end
    end

    return find_root(parent)
  end

  return find_root(vim.fn.fnamemodify(current_file, ':h')) or vim.fn.getcwd()
end

function M.set_size(size)
  local screen_height = vim.api.nvim_win_get_height(0)
  if (screen_height > size + 10) then
    return size
  else
    return screen_height
  end
end

function M.get_screen_size()
  local _win_screen_width = vim.api.nvim_win_get_width(0) or 0
  local _win_screen_height = vim.api.nvim_win_get_height(0) or 0
  return {
    width = _win_screen_width,
    height = _win_screen_height,
  }
end

return M
