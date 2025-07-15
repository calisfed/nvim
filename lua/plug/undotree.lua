return {
  enabled = false,
  lazy = false,
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" }
  },
  config = function()
    require('undotree').setup(
      {
        float_diff = false,
        layout = 'left_left_bottom', -- left_bottom, left_left_bottom
      })
    vim.keymap.set('n', '<leader>u', "<cmd>lua require('undotree').toggle()<cr>", { desc = "Toggle Undotree" })
  end
}


-- Vimscript version
-- return {
--   enabled = false,
--   lazy = false,
--   'mbbill/undotree',
--   config = function()
--     vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
--   end
-- }
