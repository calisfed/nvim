return
{
    enabled = false,
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').add({
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Toggle" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>S", group = "Session" },
      { "<leader>u", group = "Undotree" },
    })
  end,
}
