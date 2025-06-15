return {

  enabled = false,
  'iguanacucumber/highlight-actions.nvim',
  event = "VeryLazy",
  -- keys = , -- Lazy load on keymap
  -- opts = {}, -- for a default config
  opts = {
    highlight_for_count = true,   -- Should '3p' or '5u' be highlighted
    duration = 300,               -- Time in ms for the highlight
    actions = {
      Undo = {
        disabled = false,
        fg = '#dcd7ba',
        bg = '#2d4f67',
        mode = 'n',
        keymap = 'u',   -- mapping
        cmd = 'undo',   -- Vim command
        opts = {},      -- silent = true, desc = "", ...
      },
      Redo = {
        disabled = false,
        fg = '#dcd7ba',
        bg = '#2d4f67',
        mode = 'n',
        keymap = '<C-r>',
        cmd = 'redo',
        opts = {},
      },
      Pasted = {
        disabled = false,
        fg = '#dcd7ba',
        bg = '#2d4f67',
        mode = 'n',
        keymap = 'p',
        cmd = 'put',
        opts = {},
      },
      -- Any other actions you might wanna add
    },
  },
}
