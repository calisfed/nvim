return
{
  enabled = false,
  lazy = false,
  'sQVe/sort.nvim',
  keys = {
    { 'gss', "<cmd>Sort<cr>",  desc = "Sort" },
    { 'gsr', "<cmd>Sort!<cr>", desc = "Sort reverse" }
  },
  opts = function()
    local config = {}
    vim.keymap.set({ 'n', 'v' }, 'gss', '<cmd>Sort<cr>', { desc = "Sort" })
    vim.keymap.set({ 'n', 'v' }, 'gsr', '<cmd>Sort!<cr>', { desc = "Sort reverse" })
    return config
  end
}
