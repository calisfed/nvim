vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.swapfile = false
vim.g.mapleader = ' '
vim.o.winborder = 'rounded'
vim.o.splitright = true
vim.o.splitbelow = true


vim.keymap.set('n', '<leader>w', '<cmd>update<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>')
vim.keymap.set('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>')






vim.pack.add({
    { src = 'https://github.com/eldritch-theme/eldritch.nvim' },
    -- { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/rachartier/tiny-code-action.nvim', },       -- require telescope/fzf for code actions
    { src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim', }, -- inline diagnostic
    { src = 'https://github.com/rachartier/tiny-cmdline.nvim', },           -- inline diagnostic
    { src = 'https://github.com/kdheepak/lazygit.nvim', },                  -- git integration
    { src = 'https://github.com/lambdalisue/suda.vim', },                   -- auto read/write file with sudo
})
require 'tiny-code-action'.setup()
require 'tiny-inline-diagnostic'.setup()
require 'tiny-cmdline'.setup()
-- require'lazygit'.setup()

vim.keymap.set("n", "<leader>ca", function() require("tiny-code-action").code_action() end,
    { noremap = true, silent = true, desc = "Code action" })
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = "LazyGit" })


require 'eldritch'.setup()
vim.cmd 'colorscheme eldritch-dark'


vim.pack.add({ 'https://github.com/echasnovski/mini.nvim' })
require 'configs.mini'
vim.pack.add({ 'https://github.com/tpope/vim-fugitive' })
-- vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
-- require 'configs.fzf'
vim.pack.add({ 'https://github.com/onsails/lspkind.nvim' })
vim.pack.add({ 'https://github.com/chaoren/vim-wordmotion' })
vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
vim.pack.add({ 'https://github.com/mikavilpas/yazi.nvim' })
vim.pack.add({ 'https://github.com/aserowy/tmux.nvim' })
vim.pack.add { 'https://github.com/monaqa/dial.nvim' }
-- require 'configs.oil'


-- Get the full path to your config directory
local config_path = vim.fn.stdpath("config") .. "/?.lua"
local config_subdirs = vim.fn.stdpath("config") .. "/?/init.lua"
package.path = package.path .. ";" .. config_path .. ";" .. config_subdirs



vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client --[[@cast -?]]:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client --[[@cast -?]].id, ev.buf, { autotrigger = true })
        end
    end,
})



vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            -- autotrigger = true,
            -- Optional formating of items
            convert = function(item)
                -- Remove leading misc chars for abbr name,
                -- and cap field to 25 chars
                --local abbr = item.label
                --abbr = abbr:match("[%w_.]+.*") or abbr
                --abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr
                --
                -- Remove return value
                --local menu = ""

                -- Only show abbr name, remove leading misc chars (bullets etc.),
                -- and cap field to 15 chars
                local abbr = item.label
                abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
                abbr = abbr:match("[%w_.]+.*") or abbr
                abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

                -- Cap return value field to 15 chars
                local menu = item.detail or ""
                menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

                local labelDetails = {}


                -- -- print
                -- -- vim.api.nvim_win_cal
                -- if item.kind == 3 then
                -- 				abbr = 'F: ' .. abbr
                -- end



                return { abbr = abbr, menu = menu, labelDetails = labelDetails }
            end,
        })
    end,
})



vim.o.complete = ".,o"                       -- use buffer and omnifunc
vim.o.completeopt = "fuzzy,menuone,noinsert" -- add 'popup' for docs (sometimes)
-- vim.o.autocomplete = true
vim.o.pumheight = 10
vim.o.pummaxwidth = 40
vim.o.pumborder = "rounded"


require 'autocmds'
require 'keymaps'
require 'options'
require 'vim._core.ui2'.enable()
vim.api.nvim_command("packadd nvim.undotree")


vim.lsp.config.bashls = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'zsh' }
}
vim.lsp.enable({ 'emmylua_ls', 'zls', 'clangd', 'bashls' })

-- vim.lsp.inlay_hint.enable()






vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})
require 'nvim-treesitter'.install({ 'lua' })
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function() vim.treesitter.start() end,
})





require 'lspkind'.setup({ mode = 'symbol' })
vim.g.loaded_netrwPlugin = 1
require 'yazi'.setup({ open_for_directories = false, keymaps = { show_help = "<f1>", }, })

vim.keymap.set({ 'n', 'v' }, '-', '<cmd>Yazi toggle<cr>', { desc = 'Open yazi at the current file' })
vim.keymap.set({ 'n', 'v' }, '<leader>_', '<cmd>Yazi cwd<cr>', { desc = 'Open yazi at the current file' })
vim.keymap.set({ 'n', 'v' }, '<leader>-', '<cmd>Yazi<cr>', { desc = 'Open yazi at the current file' })
require 'tmux'.setup({

    copy_sync = {
        -- enables copy sync. by default, all registers are synchronized.
        -- to control which registers are synced, see the `sync_*` options.
        enable = true,

        -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
        -- first buffer or named_buffer_name = true to ignore a named tmux
        -- buffer with name named_buffer_name :)
        ignore_buffers = { empty = false },

        -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
        -- clipboard by tmux
        redirect_to_clipboard = false,

        -- offset controls where register sync starts
        -- e.g. offset 2 lets registers 0 and 1 untouched
        register_offset = 0,

        -- overwrites vim.g.clipboard to redirect * and + to the system
        -- clipboard using tmux. If you sync your system clipboard without tmux,
        -- disable this option!
        sync_clipboard = true,

        -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
        sync_registers = true,

        -- synchronizes registers when pressing p and P.
        sync_registers_keymap_put = true,

        -- synchronizes registers when pressing (C-r) and ".
        sync_registers_keymap_reg = true,

        -- syncs deletes with tmux clipboard as well, it is adviced to
        -- do so. Nvim does not allow syncing registers 0 and 1 without
        -- overwriting the unnamed register. Thus, ddp would not be possible.
        sync_deletes = true,

        -- syncs the unnamed register with the first buffer entry from tmux.
        sync_unnamed = true,
    },
    navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,

        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,

        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,

        -- sets resize steps for x axis
        resize_step_x = 1,

        -- sets resize steps for y axis
        resize_step_y = 1,
    },
    swap = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,

        -- enables default keybindings (C-A-hjkl) for normal mode
        enable_default_keybindings = true,
    }
})








local map = require('dial.map')
vim.keymap.set("n", "<C-a>", function() map.manipulate("increment", "normal") end, { desc = "Dial inc" })
vim.keymap.set("n", "<C-x>", function() map.manipulate("decrement", "normal") end, { desc = "Dial dec" })
vim.keymap.set("n", "g<C-a>", function() map.manipulate("increment", "gnormal") end, { desc = "Dial inc" })
vim.keymap.set("n", "g<C-x>", function() map.manipulate("decrement", "gnormal") end, { desc = "Dial dec" })
vim.keymap.set("v", "<C-a>", function() map.manipulate("increment", "visual") end, { desc = "Dial inc" })
vim.keymap.set("v", "<C-x>", function() map.manipulate("decrement", "visual") end, { desc = "Dial dec" })
vim.keymap.set("v", "g<C-a>", function() map.manipulate("increment", "gvisual") end, { desc = "Dial inc" })
vim.keymap.set("v", "g<C-x>", function() map.manipulate("decrement", "gvisual") end, { desc = "Dial dec" })
local augend = require("dial.augend")
require("dial.config").augends:register_group {
    -- default augends used when no group name is specified
    default = {
        augend.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        augend.constant.alias.bool,    -- boolean value (true <-> false)
        augend.constant.new {
            elements = { "and", "or" },
            word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
        },
        augend.constant.new { elements = { "&&", "||" }, word = false, cyclic = true, },
        augend.constant.new { elements = { "[x]", "[ ]" }, word = false, cyclic = true, },
    },

    neorg = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.constant.new { elements = { "and", "or" }, word = true, cyclic = true, },
        augend.constant.new { elements = { "&&", "||" }, word = false, cyclic = true, },
        augend.constant.new { elements = { "( )", "(x)", "(?)", "(!)", "(+)", "(-)", "(=)", "(_)" }, word = false, cyclic = true, },
        augend.constant.new { elements = { "*", "**", "***", "****", "*****", "******" }, word = false, cyclic = false, },
        augend.constant.new { elements = { "-", "--", "---", "----", "-----", "------" }, word = false, cyclic = false, },
        augend.constant.new { elements = { "~", "~~", "~~~", "~~~~", "~~~~~", "~~~~~~" }, word = false, cyclic = false, },
        augend.constant.new { elements = { ">", ">>", ">>>", ">>>>", ">>>>>", ">>>>>>" }, word = false, cyclic = false, },

    },

    asciidoc = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.constant.new { elements = { "and", "or" }, word = true, cyclic = true, },
        augend.constant.new { elements = { "[ ]", "[x]" }, word = true, cyclic = true, },
        augend.constant.new { elements = { "=", "==", "===", "====", "=====", "======" }, word = false, cyclic = false, },
        augend.constant.new { elements = { "*", "**", "***", "****", "*****", "******" }, word = false, cyclic = false, },
        augend.constant.new { elements = { "NOTE:", "IMPORTANT:", "TIP:", "CAUTION:", "WARNING:" }, word = true, cyclic = true, },
    },


    -- augends used when group with name `mygroup` is specified
    mygroup = {
        augend.integer.alias.decimal,
        augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
    }
}

-- -- change augends in VISUAL mode
-- vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual("visual"), {noremap = true})
-- vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual("visual"), {noremap = true})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.norg", },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("neorg"),
            { noremap = true, desc = "Dial inc neorg" })
        vim.api.nvim_buf_set_keymap(0, "n", "<C-x>", require("dial.map").dec_normal("neorg"),
            { noremap = true, desc = "Dial dec neorg" })
        vim.api.nvim_buf_set_keymap(0, "v", "<C-a>", require("dial.map").inc_visual("neorg"),
            { noremap = true, desc = "Dial inc neorg" })
        vim.api.nvim_buf_set_keymap(0, "v", "<C-x>", require("dial.map").dec_visual("neorg"),
            { noremap = true, desc = "Dial dec neorg" })
    end
})
