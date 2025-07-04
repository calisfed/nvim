return {
  enabled = false,
  lazy = true,
  event = "VeryLazy",
  'kdheepak/lazygit.nvim',
  dependencies = {
    "nvim-lua/plenary.nvim", -- optional for floating window border decoration
  },
  cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile", },
  -- keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
  config = function()
    vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
    vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
    vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
    vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
    vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

    vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
    vim.g.lazygit_config_file_path = '' -- custom config file path
    -- OR
    vim.g.lazygit_config_file_path = {} -- table of custom config file paths

    vim.g.lazygit_on_exit_callback = nil -- optional function callback when exiting lazygit (useful for example to refresh some UI elements after lazy git has made some changes)
    vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = "LazyGit" })
    -- require("telescope").load_extension("lazygit")
  end

}
