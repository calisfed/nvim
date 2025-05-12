
function cent() 
  local cur_node = vim.treesitter.get_node()
  local sr,sc,er,ec = vim.treesitter.get_node_range(cur_node)
  vim.print(sr, sc,er,ec)
end

vim.keymap.set('n', 'z', cent)
