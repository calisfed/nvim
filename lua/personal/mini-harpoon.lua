-- https://www.reddit.com/r/neovim/comments/1js5bg8/harpoon_in_50_lines_of_lua_code_using_native/

for i = 1, 9 do
local mark_char = string.char(64 + i) -- A=65, B=66, etc.
vim.keymap.set("n", "<leader>" .. i, function()
  local mark_pos = vim.api.nvim_get_mark(mark_char, {})
    if mark_pos[1] == 0 then
      vim.cmd("normal! gg")
      vim.cmd("mark " .. mark_char)
      vim.cmd("normal! ``") -- Jump back to where we were
    else
      vim.cmd("normal! `" .. mark_char) -- Jump to the bookmark
      vim.cmd('normal! `"') -- Jump to the last cursor position before leaving
    end
  end, { desc = "Toggle mark " .. mark_char })
end

-- Delete mark from current buffer
vim.keymap.set("n", "<leader>bd", function()
  for i = 1, 9 do
    local mark_char = string.char(64 + i)
    local mark_pos = vim.api.nvim_get_mark(mark_char, {})

    -- Check if mark is in current buffer
    if mark_pos[1] ~= 0 and vim.api.nvim_get_current_buf() == mark_pos[3] then
      vim.cmd("delmarks " .. mark_char)
    end
  end
end, { desc = "Delete mark" })

-- Populate and open quickfix list with all bookmarks
vim.keymap.set("n", "<leader>bb", function()
  -- Refresh the bookmark cache to ensure it's up-to-date
  -- refresh_bookmark_cache()

  -- Create a list to hold quickfix items
  local qf_list = {}

  -- Loop through all possible marks (A-I)
  for i = 1, 9 do
    local mark_char = string.char(64 + i) -- A=65, B=66, etc.
    local mark_pos = vim.api.nvim_get_mark(mark_char, {})

    -- Check if the mark exists
    if mark_pos[1] ~= 0 then
      -- Get the buffer number
      local buf_nr = mark_pos[3]
      -- Get the buffer name
      local buf_name = vim.api.nvim_buf_get_name(buf_nr)
      if buf_nr == 0 then
        buf_name = mark_pos[4]
      end

      -- Add to quickfix list
      table.insert(qf_list, {
        bufnr = buf_nr,
        filename = buf_name,
        lnum = mark_pos[1],
        col = mark_pos[2],
        text = i,
      })
    end
  end

  -- Set the quickfix list
  vim.fn.setqflist(qf_list)

  -- Open the quickfix window if there are bookmarks
  if #qf_list > 0 then
    vim.cmd("copen")
  else
    vim.cmd("cclose")
  end
end, { desc = "List all bookmarks" })
