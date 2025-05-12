-- utils
local utils = require 'personal.utils'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- Diagnostic keymaps
vim.keymap.set({ 'n', 'v' }, '[d', "<cmd>lua vim.diagnostic.jump({count=-1})<cr>", { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set({ 'n', 'v' }, ']d', "<cmd>lua vim.diagnostic.jump({count=1})<cr>", { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set({ 'n', 'v' }, '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set({ 'n', 'v' }, '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- vim.keymap.set({ 'n', 'v' }, '<leader>x', utils.system_open, { desc = 'Open file under cursor' }) -- gx default
-- vim.keymap.set({ 'n', 'v' }, '<leader>x', utils.open_local_file_in_new_buffer, { desc = 'Open file under cursor' }) -- gf default
vim.keymap.set({ 'n', 'v' }, '<leader>q', ':q<cr>', { desc = 'Quit' })
vim.keymap.set({ 'n', 'v' }, '<leader>w', ':w<cr>', { desc = 'Write' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>p', [["_dP]], { desc = 'Multiple paste' }) -- Without yank to clipboard
-- vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+dP]], { desc = 'Multiple paste' }) -- Without yank to clipboard
vim.keymap.set({ 'n', 'x' }, 'P', [["0p]], { desc = 'paste from yank register' })

-- Invert highlight search
-- vim.keymap.set({ 'n', 'v' }, '<leader><CR>', ':set invhlsearch<CR>', { desc = 'Inverse higlight' })

-- Replace the word that the cursor was on
-- vim.keymap.set({ 'n', 'v' }, '<leader>S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word doc' })

-- make the file into something executable
vim.keymap.set({ 'n', 'v' }, '<leader>X', '<cmd>!chmod +x %<CR>', { desc = 'Make file executable' })

-- Resize with arrows
vim.keymap.set({ 'n', 'v' }, '<C-Up>', ':resize -2<CR>', { desc = '.' })
vim.keymap.set({ 'n', 'v' }, '<C-Down>', ':resize +2<CR>', { desc = '.' })
vim.keymap.set({ 'n', 'v' }, '<C-Left>', ':vertical resize +2<CR>', { desc = '.' })
vim.keymap.set({ 'n', 'v' }, '<C-Right>', ':vertical resize -2<CR>', { desc = '.' })

-- Add line above cursor (oposite of 'o')
vim.keymap.set({ 'n', 'i' }, '<S-cr>', "<cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = 'Append live above' })


-- vim.keymap.set({ 'n', 'v' }, ';', ':lua require"utils".add_last_char(string.char(vim.fn.getchar()))<cr>', { desc = 'Add ; EOL', silent = true })
vim.keymap.set('n', '<M-;>', utils.add_last_charv2, { desc = 'Add ; EOL', silent = true })
vim.keymap.set('n', 'c;', utils.change_last_char, { desc = 'Change EOL char' })





-- Buffer

vim.keymap.set({ 'n', 'v' }, ']b', ':bnext<cr>', { desc = 'Buffer next' })
vim.keymap.set({ 'n', 'v' }, '[b', ':bprevious<cr>', { desc = 'Buffer previous' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>bd', ':bdelete<cr>', { desc = 'Buffer delete' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>bw', utils.bufwipe, { desc = 'Wipe buffers' })
vim.keymap.set({ 'n', 'v' }, '<C-w>b', utils.bufwipe, { desc = "Wipe buffer" })
vim.keymap.set({ 'n', 'v' }, '<C-c>', ':bdelete<cr>', { desc = 'Buffer delete' })

vim.keymap.set({ 'n', 'v' }, '<leader>td', utils.toggle.diagnostic, { desc = 'Toggle Diagnostic' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>tl', '<cmd>lua require("base.lsp_lines").toggle()<cr>', { desc = 'Toggle lsp_lines' })


-- vim.keymap.set({ 'n', 'v' }, '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'LSP hover' }) -- replace by K
vim.keymap.set({ 'n', 'v' }, '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'LSP format' })
vim.keymap.set({ 'n', 'v' }, '<leader>f', utils.indent_and_return, { desc = 'Indent all doc><Esc>ument' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>f', '<cmd>lua require("utils").indent_block()<cr>', { desc = 'Indent block' })




-- vim.keymap.set({ 'n', 'v' }, '<leader>m', '<cmd>messages<cr>', { desc = 'asd block' })
-- vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux_sessionizer.sh<cr>')
-- vim.keymap.set('n', '<C-d>', '<cmd>silent !tmux neww tmux_sessionizer.sh<cr>')



vim.keymap.set({ 'c' }, "<M-.>", "\\(.*\\)", { desc = "One eye Kirby" })
vim.keymap.set({ 'c' }, "<M-l>", "lua ", { desc = "Lua ready" })

-- vim.keymap.set('n', "<leader>tv", ":vsp term://zsh<cr>", { desc = "Open term in vertical split" })
-- vim.keymap.set('n', "<leader>th", ":sp term://zsh<cr>", { desc = "Open term in horizontal split" })
-- vim.keymap.set('n', "<leader>ss", ":source %<cr>", { desc = "Source this file" })

-- vim.keymap.set('n', 'gf', utils.fix_gf, { desc = "Better gf" })
vim.keymap.set('n', '<leader>tt', '<cmd>s@false@true<cr>', { desc = "Toggle false to true" })
vim.keymap.set('n', '<leader>tf', '<cmd>s@true@false<cr>', { desc = "Toggle true to false" })

-- vim.keymap.set({"s","v","n","i"}, "<C-l>", "<cmd>lua vim.snippet.jump(1)<cr>")
-- vim.keymap.set({"s","v","n","i"}, "<C-h>", "<cmd>lua vim.snippet.jump(-1)<cr>")
--

-- vim.keymap.set('n', '<leader>cm', utils.c_man, {desc = "Get man page of nearest previous function"})
vim.keymap.set('n', '<leader>cm', "<cmd>lua require('personal.man').run()<cr>", { desc = "Get man page of nearest previous function" })
