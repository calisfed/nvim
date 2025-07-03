return {
  "tris203/precognition.nvim",
  enabled = false,
  lazy = true,
  keys = {
    vim.keymap.set('n', '<leader>tp', '<cmd>lua require("precognition").toggle()<cr>', { desc = "Toggle Precognigtion" })
  },
  opts = function ()
    local config = {}
    return config
  end
}
