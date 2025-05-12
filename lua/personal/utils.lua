local M = {}

-- Return the path of the folder that contain this file
-- https://stackoverflow.com/questions/9145432/load-lua-files-by-relative-path
--- @type any
M.thisPath = (...):match '(.-)[^%.]+$'


M.bufwipe = function()
  -- Wipe all buffer except current one
  local listbuf = vim.api.nvim_list_bufs()
  local current_bufnr = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(listbuf) do
    if buf ~= current_bufnr and buf ~= 0 then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end

M.tele_ff_git_root = function()
  -- Find files from git root with telescope
  local function is_git_repo()
    vim.fn.system 'git rev-parse --is-inside-work-tree'
    return vim.v.shell_error == 0
  end
  local function get_git_root()
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
  end
  local opts = {}
  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end
  require('telescope.builtin').find_files(opts)
end


function M.is_git_repo()
  vim.fn.system 'git rev-parse --is-inside-work-tree'
  return vim.v.shell_error == 0
end

function M.get_git_root()
  local dot_git_path = vim.fn.finddir('.git', '.;')
  return vim.fn.fnamemodify(dot_git_path, ':h')
end


M.toggle = {
  diagnostic = function()
    local config = vim.diagnostic.config
    local vt = config().virtual_text
    config {
      virtual_text = not vt,
      underline = not vt,
      -- signs = not vt,
    }
  end,

}

---@param key string
M.add_last_char = function(key)
  local cmd = '<Esc>mmA' .. key .. '<Esc>`m'
  vim.api.nvim_input(cmd)
end

-- Add a character at EOL
M.add_last_charv2 = function()
  local key = string.char(vim.fn.getchar())
  local cmd = '<Esc>mmA' .. key .. '<Esc>`m'
  vim.api.nvim_input(cmd)
end

-- Change last character
M.change_last_char = function()
  local key = string.char(vim.fn.getchar())
  local cmd = '<Esc>mm$<Esc>r' .. key .. '<Esc>`m'
  vim.api.nvim_input(cmd)
end


-- Indent
M.indent_and_return = function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Save the current cursor position
  vim.cmd("normal! gg=G")                           -- Indent the entire document
  vim.api.nvim_win_set_cursor(0, cursor_pos)        -- Restore the cursor position
  vim.cmd("normal! zz")                             -- Center current line
end

-- Indent block
M.indent_block = function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Save the current cursor position
  vim.cmd("normal! Vip%=<Esc><Esc>")
  vim.api.nvim_win_set_cursor(0, cursor_pos)        -- Restore the cursor position
end

-- this gf support ZIg
function M.fix_gf()
  local str = vim.fn.expand("<cWORD>")
  if string.match(str, "%f[%a]zig%f[%A]") then
    local file_path = str:match("file://([^#]*)")
    local line_number = str:match("#L(%d+)")
    vim.api.nvim_command('vsplit' .. file_path)
    vim.api.nvim_command(line_number)
  else
    vim.fn.feedkeys("gf", "n")
  end
end

function M.c_man()
  local num = vim.v.count or 1
  local str = vim.fn.expand("<cword>")
  vim.cmd("vert Man " .. num .. " " .. str)
end


function M.trim_path(path, num_components) -- Split the path into components using '/' as the delimiter
  -- Example usage:
  -- local full_path = "/home/user/projects/nvim/config/init.lua"
  -- local trimmed_path = trim_path(full_path, 2) -- Trims to the last 2 components with a leading '/'
  -- print(trimmed_path)
  -- Output: "/config/init.lua"
  -- trimmed_path = trim_path(full_path, 3) -- Trims to the last 3 components with a leading '/' print(trimmed_path)
  -- Output: "/nvim/config/init.lua"
  local components = {}
  for component in path:gmatch("[^/]+") do
    table.insert(components, component)
  end -- Extract the last 'num_components'
  local start_index = math.max(#components - num_components + 1, 1)
  local trimmed_path = '/' .. table.concat(components, '/', start_index)
  return trimmed_path
end

function M.shorten_path(path, max_length)
  -- Example usage:
  -- local full_path = "/home/user/projects/nvim/config/init.lua"
  -- local shortened_path = shorten_path(full_path, 35)
  -- print(shortened_path)
  -- Output: "/h/u/p/nvim/config/init.lua" or "home/user/projects/nvim/config/init.lua"
  if #path <= max_length then
    return path end
  local components = {}
  for component in path:gmatch("[^/]+") do
    table.insert(components, component) end
  -- Ensure we always keep the last two components (parent directory and file)
  local file_component = table.remove(components)
  local parent_component = table.remove(components)
  for i = 1, #components do components[i] = components[i]:sub(1, 1)
  end

  local shortened_path = '/' .. table.concat(components, "/") .. '/' .. parent_component .. '/' .. file_component

  if #shortened_path > max_length then -- In case even the shortened path is longer than max_length
    local tail = table.concat(components, "/", #components - 2)
    return "..." .. tail .. '/' .. parent_component .. '/' .. file_component
  end
  return shortened_path
end


function M.url_encode(str)
  --usage:
  -- /home/v/.config -> %2Fhome%2Fv%2F.config
  return str:gsub("([^%w])",function(c)
    return string.format("%%%02X", string.byte(c))
  end)
end

function M.url_decode(str)
  return str:gsub("%%(%x%x)",
    function(hex) return string.char(tonumber(hex, 16)) end)
end



return M
