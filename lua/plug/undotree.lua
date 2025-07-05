return {
  enabled = false,
  lazy = false,

  -- 'jiaoshijie/undotree',
  'mbbill/undotree',
  -- dependencies = 'nvim-lua/plenary.nvim',
  -- keys = {
  --   { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" }
  -- },
  config = function()
    -- require('undotree').setup()
    -- vim.keymap.set('n', '<leader>u', "<cmd>lua require('undotree').toggle()<cr>", { desc = "Toggle Undotree" })
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
  end
}
