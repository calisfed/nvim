return {
-- Autoformat
    enabled = false,
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    -- keys = {
    --   vim.keymap.set({ 'n', 'v' }, '<leader>F', function()
    --     require('conform').format { async = true, lsp_fallback = false }
    --   end, { desc = 'Format current buffer with LSP' }),
    -- },
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      },
      formatters_by_ft = {
        -- lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  }
