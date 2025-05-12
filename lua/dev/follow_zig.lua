-- [Dir](file:///usr/lib/zig/std/fs/Dir.zig#L2691):

local M = {}

function M.fix_gf()
local str = vim.fn.expand("<cWORD>")
if string.match(str, "%f[%a]zig%f[%A]") then
  local file_path = str:match("file://([^#]*)")
  local line_number = str:match("#L(%d+)")
  -- print(file_path)
  vim.api.nvim_command('vsplit' .. file_path)
  -- print(line_number)
  vim.api.nvim_command(line_number)
else
  vim.fn.feedkeys("gf", "n")
end
end
return M




