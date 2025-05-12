return{
    'folke/tokyonight.nvim',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    config = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  }
