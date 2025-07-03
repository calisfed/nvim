return
{
  "nvim-neorg/neorg",
  enabled = false,
  lazy = false,
  ft = { "neorg", "norg" },
  version = "*",
  dependencies = { { "vhyrro/luarocks.nvim", priority = 1000, config = true, } },
  config = function()
    local config = {
      load = {
        ['core.defaults'] = {}, -- Loads default behaviour
        ['core.concealer'] = {
          -- config = {folds = true, icon_preset = 'diamond', -- basic diamond varied }

        },               -- Adds pretty icons to your documents
        ['core.dirman'] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = '~/notes',
            },
            -- index = "index.norg", -- The name of the main (root) .norg file
          },
        },
        -- ['core.completion'] = {
        --   config = {
        --     engine = 'nvim-cmp',
        --   },
        -- },
        ['core.export'] = {},
        ['core.latex.renderer'] = {
          conceal = true,
          debouce = 200,
          dpi = 350,
          min_length = 3,
          render_on_enter = false,
        },
      }
    }
  end,
}
