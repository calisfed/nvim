return{
    "diegoulloao/neofusion.nvim",
    lazy = false,
    config = function()
      vim.o.background = 'dark'
      require('neofusion').setup({
        transparent_mode = true,
        invert_selection = true,
        invert_tabline = true,
        -- invert_intend_guides = true,
        overrides = {
          LineNr = { fg = '#00ffff' },
          ['@comment'] = { fg = '#00aaaa' },
          -- ['@string'] = { fg = '#ffff00'},
          ['@function'] = { fg = '#33dd88' },
        },
      })
      -- vim.cmd.colorscheme 'neofusion'
    end
  }
