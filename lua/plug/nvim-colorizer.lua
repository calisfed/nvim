return {
    enabled = false,
  'norcalli/nvim-colorizer.lua',
  lazy = true,
  -- event = "VeryLazy",
  keys = {
    { '<leader>tC', '<cmd>ColorizerToggle<CR>', desc = 'Toggle Colorizer' },
  },
  opts = function ()
    local config = {}
    return config
  end
}
