vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.swapfile = false
vim.g.mapleader = ' '
vim.o.winborder = 'rounded'
vim.o.splitright = true
vim.o.splitbelow = true
-- require 'vim._core.ui2'.enable()
vim.o.cmdheight = 1
vim.o.cmdwinheight = 1
-- vim.keymap.set("n","<leader>;","<Esc>q:i")
-- vim.keymap.set("n",":","<cmd>source " .. vim.fn.stdpath('config') .."/cmdline.lua<cr>")

vim.keymap.set('n', '<leader>w', '<cmd>update<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>')
vim.keymap.set('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>')



-- Get the full path to your config directory
local config_path = vim.fn.stdpath("config") .. "/?.lua"
local config_subdirs = vim.fn.stdpath("config") .. "/?/init.lua"
package.path = package.path .. ";" .. config_path .. ";" .. config_subdirs



vim.pack.add({
  { src = 'https://github.com/eldritch-theme/eldritch.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/rachartier/tiny-code-action.nvim', },       -- require telescope/fzf for code actions
  { src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim', }, -- inline diagnostic
  { src = 'https://github.com/kdheepak/lazygit.nvim', },                  -- git integration
  { src = 'https://github.com/lambdalisue/suda.vim', },                   -- auto read/write file with sudo
  { src = 'https://github.com/b0o/incline.nvim', },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons', },

})
require 'tiny-code-action'.setup({})
require 'tiny-inline-diagnostic'.setup()
require('lua.personal.cmd').setup({})
vim.keymap.set('n', '<leader><leader>', '<cmd>source %<cr>')

vim.keymap.set("n", "<leader>ca", function() require("tiny-code-action").code_action({}) end,
  { noremap = true, silent = true, desc = "Code action" })
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = "LazyGit" })


require 'eldritch'.setup()
vim.cmd 'colorscheme eldritch-dark'


vim.pack.add({ 'https://github.com/echasnovski/mini.nvim' })
require 'configs.mini'
-- source '$HOME/.config/nvim/lua/configs/mini.lua'

vim.pack.add({ 'https://github.com/tpope/vim-fugitive' })
vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
require 'configs.fzf'
vim.pack.add({ 'https://github.com/onsails/lspkind.nvim' })
vim.pack.add({ 'https://github.com/chaoren/vim-wordmotion' })
vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })
-- vim.pack.add({ 'https://github.com/mikavilpas/yazi.nvim' })
vim.pack.add({ 'https://github.com/aserowy/tmux.nvim' })
vim.pack.add { 'https://github.com/monaqa/dial.nvim' }
require 'configs.oil'





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
vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
})

require 'mason'.setup()
require 'mason-lspconfig'.setup({
  ensure_installed = { 'emmylua_ls', 'clangd', 'ty', 'bashls', 'tinymist' },
  automatic_enable = true,
})




vim.o.complete = ".,o"                       -- use buffer and omnifunc
vim.o.completeopt = "fuzzy,menuone,noinsert" --,preselect" -- add 'popup' for docs (sometimes)
-- vim.o.autocomplete = true
vim.o.pumheight = 10
vim.o.pummaxwidth = 40
vim.o.pumborder = "rounded"


require 'autocmds'
require 'keymaps'
require 'options'

vim.api.nvim_command("packadd nvim.undotree")

vim.lsp.config.emmylua_ls = {
  cmd = { 'emmylua_ls' },
  -- cmd= {
  --   vim.fn.stdpath("data") .. "/mason/bin/emmylua_ls",
  --   "--config",
  --   ".emmyrc.json",
  -- },
  root_markers = { '.emmyrc.json', '.git' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      format = {
        defaultConfig = {
          max_line_length = "200", },
        -- editorConfig = {
        --   max_line_length = 200,
        -- }
      },
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        -- Tells lua_ls where to find all the Lua files that you have loaded
        -- for your neovim configuration.
        library = {
          '${3rd}/luv/library',
          unpack(vim.api.nvim_get_runtime_file('', true)),
          -- vim.env.VIMRUNTIME,
          -- "/usr/share/awesome/lib",
        },
        -- If lua_ls is really slow on your computer, you can try this instead:
        -- library = { vim.env.VIMRUNTIME },
      },
      completion = { callSnippet = 'Replace', },
      diagnostics = { disable = { 'missing-fields' }, globals = { "vim", "awesome", "client", "root", "screen", "mouse" }, },
    },
  },
}
vim.lsp.config.clangd = {
  cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--background-index",
    -- "--compile-commands-dir=build",
    "--clang-tidy",
    "--completion-style=bundled", -- bundled, detailed
    "--header-insertion=iwyu",    -- never
    -- "--cross-file-rename", --obsolete flag, no longer in used
  },
  -- filetypes = { "c" },
  init_options = {
    clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  }
}

vim.lsp.config.tinymist = {
  -- https://github.com/Myriad-Dreamin/tinymist/blob/main/editors/vscode/Configuration.md
  settings = {
    -- exportTarget = "html",
    exportPdf = "onType",
    outputPath = "$root/target/$dir/$name",
  }
}


vim.lsp.config.bashls = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'zsh' }
}
vim.lsp.enable({ 'emmylua_ls', 'zls', 'clangd', 'bashls', 'tinymist' })

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
-- vim.g.loaded_netrwPlugin = 1
-- require 'yazi'.setup({ open_for_directories = true, keymaps = { show_help = "<f1>", }, })
-- vim.keymap.set({ 'n', 'v' }, '-', '<cmd>Yazi toggle<cr>', { desc = 'Open yazi at the current file' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>_', '<cmd>Yazi cwd<cr>', { desc = 'Open yazi at the current file' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>-', '<cmd>Yazi<cr>', { desc = 'Open yazi at the current file' })
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
    sync_clipboard = false,

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

local helpers = require 'incline.helpers'
-- local devicons = require 'nvim-web-devicons'
local devicons = require 'nvim-web-devicons'
require('incline').setup {
  window = {
    padding = 0,
    margin = { horizontal = 0 },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    if filename == '' then
      filename = '[No Name]'
    end
    local ft_icon, ft_color = devicons.get_icon_color(filename)
    local modified = vim.bo[props.buf].modified
    return {
      ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
      ' ',
      { filename, gui = modified and 'bold,italic' or 'bold' },
      ' ',
      guibg = '#44406e',
    }
  end,
}
vim.pack.add({ 'https://github.com/3rd/image.nvim' })
require("image").setup({
  backend = "sixel",        -- or "ueberzug" or "sixel" or "kitty
  processor = "magick_cli", -- or "magick_rock"
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      only_render_image_at_cursor_mode = "popup", -- or "inline"
      floating_windows = false,                   -- if true, images will be rendered in floating markdown windows
      filetypes = { "markdown", "vimwiki" },      -- markdown extensions (ie. quarto) can go here
    },
    asciidoc = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      only_render_image_at_cursor_mode = "popup",
      floating_windows = false,
      filetypes = { "asciidoc", "adoc" },
    },
    neorg = {
      enabled = true,
      filetypes = { "norg" },
    },
    rst = {
      enabled = true,
    },
    typst = {
      enabled = true,
      filetypes = { "typst" },
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = nil,
  max_height_window_percentage = 50,
  scale_factor = 1.0,
  window_overlap_clear_enabled = false,                                               -- toggles images when windows are overlapped
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
  editor_only_render_when_focused = false,                                            -- auto show/hide images when the editor gains/looses focus
  tmux_show_only_in_active_window = false,                                            -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
})
