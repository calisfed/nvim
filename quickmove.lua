vim.keymap.set('n', '<leader><leader>', '<cmd>source %<cr>')
print("tho has been sourced " .. vim.api.nvim_buf_get_name(0))

local current_win = vim.api.nvim_get_current_win()
local win_config = vim.api.nvim_win_get_config(current_win)

local width = 50
local height = 15

local editor_width = vim.api.nvim_win_get_width(current_win)
local editor_height = vim.api.nvim_win_get_height(current_win)

local row = math.floor((editor_height - height) / 2)
local col = math.floor((editor_width - width) / 2)

local buf = vim.api.nvim_create_buf(false, true)


local win = vim.api.nvim_open_win(buf, true, {
  relative = "win",
  win = current_win,
  width = width,
  height = height,
  row = row,
  col = col,
  border = "rounded",
})

-- Set buffer filetype
vim.bo[buf].filetype = "zzz"
vim.wo[win].number = true
vim.wo[win].relativenumber = false

-- Get listed buffers
local lines = {}

for _, b in ipairs(vim.api.nvim_list_bufs()) do
  if vim.bo[b].buflisted then
    local name = vim.api.nvim_buf_get_name(b)

    -- Show [No Name] for unnamed buffers
    if name == "" then
      name = "[No Name]"
    end

    -- table.insert(lines, string.format("%d: %s", b, name))
    table.insert(lines, string.format("%s | %d", name, b))
  end
end

-- Put buffer list into floating buffer
vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

function buf_change()

end
