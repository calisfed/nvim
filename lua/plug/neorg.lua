return
{
  "nvim-neorg/neorg",
  enabled = false,
  lazy = false,
  version = "*",
    dependencies = { { "vhyrro/luarocks.nvim", priority = 1000, config = true, } },
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},  -- Loads default behaviour
        ['core.concealer'] = {}, -- Adds pretty icons to your documents
        ['core.dirman'] = {      -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = '~/notes',
              -- projects = '~/projects/',
            },
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
						render_on_enter = true,
					},
      },
    }
  end,
}
