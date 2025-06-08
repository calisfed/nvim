return
{
  enabled = false,
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    -- "rcarriga/nvim-notify",
  },

  opts = {
    cmdline = {
      opts = {
        position = '50%',
        size = {
          width = '50%',
        },
        relative = {
          type = "win",
          winid = 0,
        },
          border = {
            -- style = 'single',
          }
      },
      -- format = {
      --   cmdline = { pattern = "^:%s+", icon = "", lang = "vim" },
      -- }
    },
  },
}
