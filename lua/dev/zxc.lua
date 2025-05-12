print('zxc loaded')

vim.keymap.set({ 'i', 's' }, 'z', function()
  if vim.fn.pumvisible() == 1 then
    local comp = vim.v.completed_item
    -- local comp = vim.fn.complete_info() -- This return the list
    -- local text = vim.tbl_get(comp, 'user_data', 'nvim', 'lsp', 'completion_item', 'insertText')
    local t = vim.tbl_get(comp, 'user_data', 'nvim', 'lsp', 'completion_item')
    -- local kind = vim.tbl_get(t, 'insertTextFormat')
    local kind = vim.tbl_get(t, 'kind')
    local text = vim.tbl_get(t, 'insertText')
    if text then
      vim.snippet.expand(text)
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-y>', true, false, true),'m', false)
    end
  else
    return 'z'
  end
end)


-- vim.api.nvim_create_augroup('TextChangedI', opts)
vim.api.nvim_create_autocmd('TextChangedI', {
  buffer = 0,
  callback = function()
end
})
vim.lsp.completion.BufferOpts().autotrigger = true









-- local triggers = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i','j','k','l','m','n','o','p','q','r','s','t','u','v','x','y','z','.',':'}
-- vim.api.nvim_create_autocmd("InsertCharPre", {
--   buffer = vim.api.nvim_get_current_buf(),
--   callback = function()
--     if vim.fn.pumvisible() == 1 or vim.fn.state("m") == "m" then
--       return
--     end
--     local char = vim.v.char
--     if vim.list_contains(triggers, char) then
--       local key = vim.keycode("<C-x><C-o>")
--       vim.api.nvim_feedkeys(key, "m", true)
--     end
--   end
-- })
-- -- cmdline-completion
-- -- set wildmode = longest:full
-- vim.opt.wildmode = "longest:full"
vim.opt.completeopt = "menu,noselect,noinsert,popup"

