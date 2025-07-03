return
{
  enabled = false,
  lazy = false,
  'sphamba/smear-cursor.nvim',
  event = "VeryLazy",
  opts = function()
    local config = {
      -- Cursor color. Defaults to Normal foreground color
      cursor_color = '#d3cdc3',

      -- Use floating windows to display smears outside buffers.
      -- May have performance issues with other plugins.
      use_floating_windows = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Attempt to hide the real cursor when smearing.
      hide_target_hack = false,
    }
    return config
  end
}
