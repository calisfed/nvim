
-- This function has 2 highlights because it needed to set virtual text for the
-- highlight behind text
local function padding_space()
  local bufnr = vim.fn.bufnr('%') -- Current buf number
  --- @type number
  local win_width = vim.fn.winwidth(0) -- For calculate the pad_len in for loop
  local buf_lines = vim.api.nvim_buf_line_count(bufnr) -- Get total line of the buffer

  local cur_pos = vim.api.nvim_win_get_cursor(0)[1] -- Get current position
  local hi_pos = {cur_pos + 10, cur_pos - 10, cur_pos + 20, cur_pos - 20} -- Get others locations

  local ns_id = vim.api.nvim_create_namespace("padd") -- namespace id, needed for highlight virtual text with set_extmark
  vim.cmd.highlight("mg guibg=#333333") -- Actual highlight group:

  -- Clear highlights
  -- TODO_: Clear correct highlight group only, currently is not compatible w/ Oil.nvim
  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
  vim.fn.clearmatches(0)

  -- Set highlights
  for _, pos in ipairs(hi_pos) do
    if pos > 0 and pos <= buf_lines then
      local lines = vim.api.nvim_buf_get_lines(bufnr, pos - 1, pos, false)
      local curr_line_len = string.len(lines[1])
      local pad_len = win_width - curr_line_len
      local pad_str = string.rep(" ",pad_len)
      -- Highlight not text
      vim.api.nvim_buf_set_extmark(0,ns_id, pos - 1,0,{virt_text_pos="eol",right_gravity=false, virt_text={{pad_str, "mg"}}})
      -- Highlight text
      vim.fn.matchadd("mg", '\\%' .. pos .. 'l.*')
    end
  end
end

vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
  desc = 'Highligh special lines',
  group = vim.api.nvim_create_augroup('high ligh', { clear = false }),
  callback = function()
    padding_space()
  end,
})



















