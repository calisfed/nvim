-- Summary: get multiple file contents into one and write it back

-- Config: configuration should be done directly inside source code. This one is very niche so I won't make it into a plugin
-- Default it will find all file (exclude hidden files, take a look at line 52) in the current directory
-- If needed specific file pattern then you can pass pattern into the read() function like: require'onefiler'.read("/*.zig")
-- Change M.filename_deco to suit your file type, I recommend make it a comment line
-- It will write to any file in the onefile if match, so be careful before write

-- Usage:
-- Keymap: you can assign keymap for it
-- vim.keymao.set("n", "<localleader>r", "<cmd>lua require'onefiler'.read()<CR>", { desc = "Read content of many file into one"})
-- vim.keymao.set("n", "<localleader>w", "<cmd>lua require'onefiler'.write()<CR>", { desc = "Write content of one file into many"})

-- Or Autocmds:
-- vim.api.nvim_create_autocmd("BufRead", {
--   desc = "Read content of many file into one",
--   pattern = {"*/onefiler"},
--   callback = function ()
--     require('onefiler').read()
--   end
-- })

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   desc = "Write content of one file into many",
--   pattern = {"*/onefiler"},
--   callback = function ()
--     require('onefiler').write()
--   end
-- })


local M = {}

M.pattern = "/*"
M.start_line = 1 -- 0 create a top blank line on second read
M.filename_deco = "-- File: "
M.short_filename = true
M.gap = { "", "", "" } -- This gap mean 3 blank lines, always use blank lines.

---@param pattern string
M.read = function(pattern)
  pattern = pattern or M.pattern

  local cwfile = vim.fn.expand('%:t')        -- Get current file name
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {})                                         -- Clear current file

  local cwDir = vim.fn.getcwd(0, 0)                                                       -- Get cwd
  local cwdContent = vim.split(vim.fn.glob(cwDir .. pattern), '\n', { trimempty = true }) -- Get file name base on M.pattern
  -- local cwdContent = vim.fn.readdir(cwDir) -- Note: This one get all file, included hidden file
  -- You can create some filter function here if needed for specific file
  for _, file in ipairs(cwdContent) do
    -- Make short file name
    if M.short_filename then
      file = file:gsub(".*/", "")
    end
    if file == cwfile then
      goto continue
    end

    local content = vim.fn.readfile(file)                                                         -- Read content each file
    vim.api.nvim_buf_set_lines(0, M.start_line, M.start_line, false, { M.filename_deco .. file }) -- Write file name on top first
    vim.api.nvim_buf_set_lines(0, M.start_line + 1, #content + M.start_line + 1, false, content)  -- Write file content
    vim.api.nvim_buf_set_lines(0, #content + M.start_line, #content + M.start_line, false, M.gap) -- Create gap
    M.start_line = M.start_line + #content + #M.gap + 1                                           -- Set new start line
      ::continue::
  end
end

M.write = function()
  vim.api.nvim_command('write!')             -- Force save before write to other files

  local cwfile = vim.fn.expand('%:t')        -- Get current file name
  local cwfcontent = vim.fn.readfile(cwfile) -- Get current file content
  local file_name = ""
  local old_file_name = ""
  local old_line = ""

  local new_content = {}
  for i, line in ipairs(cwfcontent) do
    if line:match(M.filename_deco) then
      file_name = line:gsub(M.filename_deco, "") -- Achive filename by remove filename_deco

      if old_file_name == "" then
        old_file_name = file_name
      end

      -- Write to old_file_name and reset new_content
      if file_name ~= old_file_name then
        vim.fn.writefile(new_content, old_file_name)
        new_content = {}
        old_file_name = file_name
      end

      goto continue
    end

    -- Dealing with multiple blank lines
    if line == old_line and old_line == "" then
      goto continue
    end

    new_content = vim.fn.extend(new_content, { line })
    old_line = line

    -- Dealing with EOF
    if i == #cwfcontent then
      vim.fn.writefile(new_content, file_name)
    end

    ::continue::
  end
end

return M
