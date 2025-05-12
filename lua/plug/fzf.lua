return
{
  enabled = false,
  lazy = false,
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {}
    vim.keymap.set({ 'n', 'v' }, '<leader>sh', ':FzfLua help_tags<CR>', { desc = '[S]earch [H]elp' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sk', ':FzfLua keymaps<CR>', { desc = '[S]earch [K]eymaps' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sf', ':FzfLua files<CR>', { desc = '[S]earch [F]iles' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', ':FzfLua grep_cword<CR>', { desc = '[S]earch current [W]ord' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sg', ':FzfLua live_grep<CR>', { desc = '[S]earch by [G]rep' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sd', ':FzfLua diagnostics_document<cr>', { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sr', ':FzfLua resume<cr>', { desc = '[S]earch [R]esume' })
    vim.keymap.set({ 'n', 'v' }, '<leader>s.', ':FzfLua oldfiles<cr>',
      { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set({ 'n', 'v' }, '<leader><leader>', ':FzfLua buffers<cr>', { desc = '[ ] Find existing buffers' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sn', ':FzfLua files cwd=$HOME/.config/nvim/<CR>',
      { desc = '[S]earch [N]eovim files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cd', ':FzfLua lsp_definitions<cr>', { desc = '[C]ode go to [D]efinitions' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ct', ':FzfLua lsp_type_definitions<cr>',
      { desc = '[C]ode go to [T]ype definitions' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cr', ':FzfLua lsp_references<cr>', { desc = '[C]ode go to [R]eferences' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cD', ':FzfLua lsp_document_diagnostics<cr>',
      { desc = '[C]ode list [D]iagnostics' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = '[C]ode [H]over' })
    vim.keymap.set({ 'n', 'v' }, 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = '[C]ode [H]over' })
    vim.keymap.set({ 'n', 'v' }, 'gd', ':FzfLua lsp_definitions<cr>', { desc = '[G]oto [D]efinition' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', ':FzfLua lsp_code_actions<cr>', { desc = '[C]ode [A]ction' })
  end,
}
