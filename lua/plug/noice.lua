return {
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
      view = 'cmdline',
      opts = {
        -- position = '100%',
        -- size = {
        --   width = '100%',
        -- },
        relative = {
          type = "win",
          winid = 0,
        },
        border = {
          -- style = 'single',
          -- padding = 1,
          -- style = { "", "", "", "", "", "", "", "" },
        }
      },
      -- format = {
      --   cmdline = { pattern = "^:%s+", icon = "", lang = "vim" },
      -- }
    },
    lsp = {
      hover = { enabled = false },
      signature = { enabled = false, },
      message = { enabled = false },
    },
    messages = {
      enabled = false,
    },
    popmenu = {
      enabled = false,
    },
    preset = {
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true,    -- add a border to hover docs and signature help
    }


  },
}
