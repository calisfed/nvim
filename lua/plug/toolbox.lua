return {
  -- TODO: invest in the future for possibilities
  enabled = false,
  event = "VeryLazy",
  'DanWlker/toolbox.nvim',
  config = function()
    require('toolbox').setup {
      commands = {
        --replace the bottom two with your own custom functions
        { name = 'Format Json',                    execute = "%!jq '.'",                        require_input = true, },
        { name = 'Format Json (Function version)', execute = function() vim.cmd "%!jq '.'" end, },
      },
    }

    vim.keymap.set('n', '<leader>tb', require('toolbox').show_picker, { desc = 'Tool box' })
  end,
}
