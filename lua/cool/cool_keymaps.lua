
-- Replace surround, haven't take a look yet

vim.keymap.set("v", "'", [[:s/\%V\(.*\)\%V/'\1'/ <CR>]], { desc = "Surround selection with '" })
vim.keymap.set("v", '"', [[:s/\%V\(.*\)\%V/"\1"/ <CR>]], { desc = 'Surround selection with "' })
vim.keymap.set("v", '*', [[:s/\%V\(.*\)\%V/*\1*/ <CR>]], { desc = "Surround selection with *" })

vim.keymap.set("n", '<leader>s*', [[:s/\<<C-r><C-w>\>/*<C-r><C-w>\*/ <CR>]], { desc = "Surround word with *" })
vim.keymap.set("n", '<leader>s"', [[:s/\<<C-r><C-w>\>/"<C-r><C-w>\"/ <CR>]], { desc = 'Surround word with "' })
vim.keymap.set("n", "<leader>s'", [[:s/\<<C-r><C-w>\>/'<C-r><C-w>\'/ <CR>]], { desc = "Surround word with '" })

--
-- https://www.reddit.com/r/vim/comments/1dzqmuj/external_commands_dont_get_enough_attention_but/

