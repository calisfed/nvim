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

  opts = function()
    local config = {
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
        format = {
          -- cmdline = { pattern = "^:%s+", icon = "", lang = "vim" },
          input = { view = 'cmdline', },
        }
      },
      lsp = {
        hover = {
          enabled = false,
          override = function(_, result, ctx, config)
            local bufnr, winnr = vim.lsp.util.open_floating_preview(result.contents, "markdown", config)
            vim.wo[winnr].conceallevel = 0
            vim.wo[winnr].concealcursor = ""
            return bufnr, winnr
          end,
        },
        signature = { enabled = false, },
        message = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      messages = { enabled = false, },
      popmenu = { enabled = false, },
      preset = {
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      }
    }
    return config
  end
}
