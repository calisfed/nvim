
vim.api.nvim_create_autocmd({'CmdlineChanged'}, {
  pattern =  '*',
  callback = function()
    require('mini.completion').auto_completion()
end
})
