return {
  enabled = false,
  lazy = false,
  'brianhuster/live-preview.nvim',
  dependencies = {
    -- You can choose one of the following pickers
    'nvim-telescope/telescope.nvim',
    -- 'ibhagwan/fzf-lua',
    -- 'echasnovski/mini.pick',
  },
  cmd = {"LPs"},
  -- require('livepreview.config').set()
  config = function()
    require('livepreview.config').set({
      port = 5500,
      browser = 'qutebrowser', -- default mean system default
      dynamic_root = false,
      sync_scroll = true,
      -- picker = "",
    })
  end
}
