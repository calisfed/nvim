-- utils
local utils = require 'personal.utils'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- Diagnostic keymaps
vim.keymap.set({ 'n', 'v' }, '[d', "<cmd>lua vim.diagnostic.jump({count=-1})<cr>", { desc = '[K] Go to previous [D]iagnostic message' })
vim.keymap.set({ 'n', 'v' }, ']d', "<cmd>lua vim.diagnostic.jump({count=1})<cr>", { desc = '[K] Go to next [D]iagnostic message' })
vim.keymap.set({ 'n', 'v' }, '<leader>e', vim.diagnostic.open_float, { desc = '[K] Show diagnostic [E]rror messages' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>Q', vim.diagnostic.setloclist, { desc = '[K] Open diagnostic [Q]uickfix list' })
vim.keymap.set({ 'n', 'v' }, '<leader>Q', vim.diagnostic.setqflist, { desc = '[K] Open diagnostic [Q]uickfix list' })

-- vim.keymap.set({ 'n', 'v' }, '<leader>x', utils.system_open, { desc = '[K] Open file under cursor' }) -- gx default
-- vim.keymap.set({ 'n', 'v' }, '<leader>x', utils.open_local_file_in_new_buffer, { desc = '[K] Open file under cursor' }) -- gf default
vim.keymap.set({ 'n', 'v' }, '<leader>q', '<cmd>q<cr>', { desc = '[K] Quit' })
vim.keymap.set({ 'n', 'v' }, '<leader>w', '<cmd>w<cr>', { desc = '[K] Write' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>p', [["_dP]], { desc = 'Multiple paste' }) -- Without yank to clipboard
-- vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+dP]], { desc = 'Multiple paste' }) -- Without yank to clipboard
vim.keymap.set({ 'n', 'x' }, 'P', [["0p]], { desc = '[K] paste from yank register' })
-- Invert highlight search
-- vim.keymap.set({ 'n', 'v' }, '<leader><CR>', ':set invhlsearch<CR>', { desc = '[K] Inverse higlight' })

-- Replace the word that the cursor was on
-- vim.keymap.set({ 'n', 'v' }, '<leader>S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[K] Replace word doc' })

-- make the file into something executable
vim.keymap.set({ 'n', 'v' }, '<leader>X', '<cmd>!chmod +x %<CR>', { desc = '[K] Make file executable' })

-- Resize with arrows
vim.keymap.set({ 'n', 'v' }, '<C-Up>', '<cmd>resize -2<CR>', { desc = '[K] .' })
vim.keymap.set({ 'n', 'v' }, '<C-Down>', '<cmd>resize +2<CR>', { desc = '[K] .' })
vim.keymap.set({ 'n', 'v' }, '<C-Left>', '<cmd>vertical resize +2<CR>', { desc = '[K] .' })
vim.keymap.set({ 'n', 'v' }, '<C-Right>', '<cmd>vertical resize -2<CR>', { desc = '[K] .' })

-- Add line above cursor (oposite of 'o')
vim.keymap.set({ 'n', 'i' }, '<S-cr>', "<cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = '[K] Append live above' })


-- vim.keymap.set({ 'n', 'v' }, ';', '<cmd>lua require"utils".add_last_char(string.char(vim.fn.getchar()))<cr>', { desc = '[K] Add ; EOL', silent = true })
vim.keymap.set({ 'n', 'i' }, '<M-;>', utils.add_last_charv2, { desc = '[K] Add ; EOL', silent = true })
vim.keymap.set('n', 'c;', utils.change_last_char, { desc = '[K] Change EOL char' })
-- Buffer

vim.keymap.set({ 'n', 'v' }, ']b', '<cmd>bnext<cr>', { desc = '[K] Buffer next' })
vim.keymap.set({ 'n', 'v' }, '[b', '<cmd>bprevious<cr>', { desc = '[K] Buffer previous' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>bd', '<cmd>bdelete<cr>', { desc = '[K] Buffer delete' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>bw', utils.bufwipe, { desc = '[K] Wipe buffers' })
vim.keymap.set({ 'n', 'v' }, '<C-w>b', utils.bufwipe, { desc = '[K] Wipe buffer' })
vim.keymap.set({ 'n', 'v' }, '<C-c>', '<cmd>bdelete<cr>', { desc = '[K] Buffer delete' })

vim.keymap.set({ 'n', 'v' }, '<leader>td', utils.toggle.diagnostic, { desc = '[K] Toggle Diagnostic' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>tl', '<cmd>lua require("base.lsp_lines").toggle()<cr>', { desc = '[K] Toggle lsp_lines' })


-- vim.keymap.set({ 'n', 'v' }, '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = '[K] LSP hover' }) -- replace by K
vim.keymap.set({ 'n', 'v' }, '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = '[K] LSP format' })
vim.keymap.set({ 'n', 'v' }, '<leader>f', utils.indent_and_return, { desc = '[K] Indent all doc><Esc>ument' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>f', '<cmd>lua require("utils").indent_block()<cr>', { desc = '[K] Indent block' })




-- vim.keymap.set({ 'n', 'v' }, '<leader>m', '<cmd>messages<cr>', { desc = '[K] asd block' })
-- vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux_sessionizer.sh<cr>')
-- vim.keymap.set('n', '<C-d>', '<cmd>silent !tmux neww tmux_sessionizer.sh<cr>')



vim.keymap.set({ 'c' }, "<M-.>", "\\(.*\\)", { desc = '[K] One eye Kirby' })
vim.keymap.set({ 'c' }, "<M-l>", "lua ", { desc = '[K] Lua ready' })

-- vim.keymap.set('n', "<leader>tv", "<cmd>vsp term://zsh<cr>", { desc = '[K] Open term in vertical split' })
-- vim.keymap.set('n', "<leader>th", "<cmd>sp term://zsh<cr>", { desc = '[K] Open term in horizontal split' })
-- vim.keymap.set('n', "<leader>ss", "<cmd>source %<cr>", { desc = '[K] Source this file' })

-- vim.keymap.set('n', 'gf', utils.fix_gf, { desc = '[K] Better gf' })

-- Replaced by dial.nvim
-- vim.keymap.set('n', '<leader>tt', '<cmd>s@false@true<cr>', { desc = '[K] Toggle false to true' })
-- vim.keymap.set('n', '<leader>tf', '<cmd>s@true@false<cr>', { desc = '[K] Toggle true to false' })

-- vim.keymap.set({"s","v","n","i"}, "<C-l>", "<cmd>lua vim.snippet.jump(1)<cr>")
-- vim.keymap.set({"s","v","n","i"}, "<C-h>", "<cmd>lua vim.snippet.jump(-1)<cr>")
--

-- vim.keymap.set('n', '<leader>cm', utils.c_man, {desc = '[K] Get man page of nearest previous function'})
vim.keymap.set('n', '<leader>cm', "<cmd>lua require('personal.man').run()<cr>", { desc = '[K] Get man page of nearest previous function' })

vim.keymap.set('n', "<M-s>", "<cmd>source %<cr>", { desc = "[K] Source current file" })

vim.keymap.set({ 'n', 'v' }, 'K', '<cmd>lua vim.lsp.buf.hover({border="single",max_height=25,max_width=120})<cr>', { desc = '[K] Code Hover' })
vim.keymap.set({ 'n', 'v' }, '<M-K>', '<cmd>lua vim.lsp.buf.signature_help({border="single",max_height=25,max_width=120})<cr>', { desc = '[K] Signature help' })
