return{
    'EdenEast/nightfox.nvim',
    lazy = false,
    config = function()
      require('nightfox').setup {
        options = {
          transparent = true,
          dim_inactive = true,
          terminal_colors = true,
          styles = {             -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "bold",
            functions = "NONE",
            keywords = "italic",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "italic,bold",
            variables = "NONE",
          },
          inverse = {
            match_paren = true,
            visual = false,
            search = false,
          },
        },
        paletes = {
          all = {
            bg = '#1B0E25',
          },
        },
        groups = {
          -- carbonfox = {
          --   StatusLine = { bg = '#2e3440' },
          --   NormalFloat = { bg = '#011627' },
          --   FloatBorder = { bg = '#011627' },
          --   ColorColumn = { bg = '#112637' },
          --   CursorLine = { bg = '#112637' },
          --   StatusLineNC = {bg = '#112637' },
          --   -- WarningMsg = {bg = '#112637' },
          -- },
        },
      }
      vim.cmd.colorscheme 'carbonfox'
    end,
  }
