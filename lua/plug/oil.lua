return {
  {
    enabled = false,
    'stevearc/oil.nvim',
    lazy = false,
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- dependencies =  { "echasnovski/mini.icons", opts = {} },
    -- keys = { '-', '<cmd>Oil<CR>' , desc = "File explorer"},
    opts = false,
    config = function()
      require('oil').setup({
        vim.keymap.set('n', '-', '<cmd>lua require"oil".toggle_float()<CR>', { desc = 'File explorer', silent = true }),
        -- vim.keymap.set('n', '-', '<cmd>lua require"oil".open()<CR>', { desc = 'File explorer', silent = true }),

        cleanup_delay_ms = 100,
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = false,
        delete_to_trash = true,
        colums = { "icons", "permissions", "size", "mtime", },
        win_options = {
          signcolumn = "yes",
        },
        view_options = { show_hidden = true, },
        watch_for_changes = true,

        keymaps = {
          ['<C-space>'] = 'actions.select',
          -- ['h'] = 'actions.parent',
          ['<C-h>'] = 'actions.parent',
          ['l'] = 'actions.select',
          ['<Down>'] = 'actions.preview_scroll_down',
          ['<Up>'] = 'actions.preview_scroll_up',
          ['<Esc>'] = 'actions.close',
        },

        float = {
          padding = 2,
          max_width = 150,
          max_height = 200,
          border = 'rounded',
          win_options = {
            winblend = 0,
          },
        },
      })
    end
  },
  {
    lazy = false,
    "benomahony/oil-git.nvim",
    dependencies = { "stevearc/oil.nvim" },
    opts = function()
      local config = {
        highlights = {
          OilGitModified = { fg = "#ff0000" }, -- Custom colors
        }
      }
      return config
    end

  },
  {
    "Eutrius/Otree.nvim",
    lazy = false,
    dependencies = {
      "stevearc/oil.nvim",
      -- { "echasnovski/mini.icons", opts = {} },
      -- "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local config = {}
      return config
    end
  }
}
