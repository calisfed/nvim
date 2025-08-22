
local bufnr = vim.api.nvim_win_get_buf(0)
local buf_path = vim.fn.getbufinfo(bufnr)[1]

vim.cmd ( 'tabedit ' .. buf_path--[[@cast -?]].name )





