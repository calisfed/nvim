return {
  enabled = false,
  'camerondixon/hex-reader.nvim',
  keys = {
    -- {"<leader>hx", function () require('hex-reader').toggle() end, {desc = "Toggle hex reader"}}

  },
  opts = function()
    local config = {}
    vim.keymap.set("n", "<leader>hx", function()
      require("hex_reader").toggle()
    end, { desc = "Toggle hex reader." })
    return config
  end
}
