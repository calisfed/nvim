return
{
  'tamton-aquib/duck.nvim',
  event = "VeryLazy",
  enabled = false,
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>tDh', function() require('duck').hatch() end, { desc = 'Duck Hatch' })
    vim.keymap.set({ 'n', 'v' }, '<leader>tDc', function() require('duck').cook() end, { desc = 'Duck Cook' })
  end,
}
