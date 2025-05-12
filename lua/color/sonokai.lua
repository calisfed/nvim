return{
    'sainnhe/sonokai',
    lazy = false,
    config = function()
      vim.g.sonokai_style = 'maia'
      vim.g.sonokai_transparent_background = 2
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_float_style = 'dim'                     -- "bright" "dim"
      vim.g.sonokai_diagnostic_line_highlight = 1
      vim.g.sonokai_diagnostic_virtual_text = 'highlighted' --"grey" "colored" "highlighted"
      vim.g.sonokai_enable_italic = 1
      -- vim.cmd.colorscheme 'sonokai'
    end,
  }
