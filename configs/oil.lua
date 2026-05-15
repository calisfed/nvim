vim.keymap.set('n', '-', '<cmd>lua require"oil".toggle_float()<CR>', { desc = 'File explorer', silent = true })
-- vim.keymap.set('n', '-', '<cmd>lua require"oil".open()<CR>', { desc = 'File explorer', silent = true }),
require 'oil'.setup({
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
  preview_win = {
    preview_method = "load",
    -- disable_preview = function(filename)
    -- end
  },

  keymaps = {
    ['<C-space>'] = 'actions.select',
    ['h'] = 'actions.parent',
    ['l'] = 'actions.select',
    ['<Down>'] = 'actions.preview_scroll_down',
    ['<Up>'] = 'actions.preview_scroll_up',
    ['<Esc>'] = 'actions.close',
    ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<C-b>'] = { 'actions.select', opts = { horizontal = true, } },
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
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "OilEnter",
--   callback = vim.schedule_wrap(function(args)
--     local oil = require("oil")
--     if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
--       oil.open_preview()
--     end
--   end),
-- })
