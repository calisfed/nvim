return
  {
    enabled = false,
    'akinsho/toggleterm.nvim',
    lazy = false,
    config = function()
      require('toggleterm').setup()
      local tg = function()
        if vim.v.count >= 11 and vim.v.count <= 13 then
          vim.api.nvim_command(vim.v.count .. 'ToggleTerm size=10 direction=horizontal')
        elseif vim.v.count >= 21 and vim.v.count <= 23 then
          vim.api.nvim_command(vim.v.count .. 'ToggleTerm size=60 direction=vertical')
        elseif vim.v.count >= 31 and vim.v.count <= 33 then
          vim.api.nvim_command(vim.v.count .. 'ToggleTerm direction=float')
        else
          vim.api.nvim_command 'ToggleTermToggleAll'
        end
      end
      local tc = function()
        vim.api.nvim_command('ToggleTermSendCurrentLine' .. vim.v.count)
      end
      local tv = function()
        vim.api.nvim_command('ToggleTermSendVisualLines' .. vim.v.count)
      end
      local ts = function()
        vim.api.nvim_command('ToggleTermSendVisualSelection' .. vim.v.count)
      end
      -- vim.keymap.set({ 'n', 'v', 't' }, "<leader>Tt", tg, { desc = "Toggle Term" })
      vim.keymap.set({ 'n', 'v', 't' }, '<C-`>', tg, { desc = 'ToggleTerm' })
      vim.keymap.set({ 'n', 'v', 't' }, '<leader>Tc', tc, { desc = 'Send current line' })
      vim.keymap.set({ 'n', 'v', 't' }, '<leader>Tv', tv, { desc = 'Send visual lines' })
      vim.keymap.set({ 'n', 'v', 't' }, '<leader>Ts', ts, { desc = 'Send visual selection' })
      vim.keymap.set('t', '<Esc>', '<C-\\><C-N>')
    end,
  }
