vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.suda_smart_edit = true
vim.opt.guicursor = 'n-v-c:block,i-ci-ve:ver100/,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'
vim.opt.cursorline = true -- highlight the current line
vim.opt.cursorlineopt = "screenline"
vim.opt.cursorcolumn = false

vim.opt.undofile = true
vim.opt.number = true         -- Set numbered lines
vim.opt.relativenumber = true -- Set relative numbered lines
vim.opt.numberwidth = 1
vim.opt.list = false          -- Hide characters on tabs and spaces
vim.opt.scrolloff = 0         -- Minimal number of screen lines to keep above and below the cursor
vim.opt.fillchars.eob = ' '   -- Empty lines at the end of a buffer as ` `
vim.opt.wrap = false          -- Display long lines as just one line
vim.opt.sidescrolloff = 0     -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.linebreak = true      -- Wrap long lines at a character in 'breakat'
-- vim.opt.textwidth = 80        -- Maximum width of text that is being inserted
-- vim.cmd 'set fo-=1tcro'       -- :help fo-table

vim.opt.showtabline = 1    -- 0 for no show, 1 shows if more than 1 tab, 2 always shows
vim.opt.tabstop = 2        -- Insert 2 spaces for a tab
vim.opt.softtabstop = 2    -- Number of spaces tabs count for while editing
vim.opt.shiftwidth = 2     -- the number of spaces inserted for each indentation
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart

vim.opt.signcolumn = 'yes' -- Always show the signcolumn
-- vim.opt.foldcolumn = '1'   -- '0' is not bad
-- vim.opt.foldlevel = 99                           -- Using ufo provider need a large value, feel free to decrease the value
-- vim.opt.foldlevelstart = 99                      -- Using ufo provider need a large value, feel free to decrease the value
-- vim.opt.foldenable = true                        -- Enable folding

vim.opt.hlsearch = false                         -- Highlight on search
vim.opt.incsearch = true                         -- While typing a search command, show where the pattern matches

vim.opt.conceallevel = 0                         -- so that `` is visible in markdown files
vim.opt.concealcursor = 'v'                      -- so that `` is visible in markdown files
-- vim.opt.formatoptions = vim.opt.fo:gsub('cro','') -- Avoid comments to continue on new lines
vim.opt.updatetime = 200                         -- Faster completion
vim.opt.ttimeoutlen = 5
vim.opt.mouse = 'a'                              -- Enable mouse mode
vim.opt.clipboard = 'unnamedplus'                -- Sync clipboard between OS and Neovim
vim.opt.cmdheight = 1                            -- More space in the neovim command line for displaying messages
vim.opt.breakindent = true                       -- Enable break indent
vim.opt.ignorecase = true                        -- Ignore case in search patterns
vim.opt.smartcase = true                         -- Override `'ignorecase'` if the search pattern contains upper case characters
vim.opt.wildignore:append { '*/node_modules/*' } -- Ignore when expanding wildcards, completing file or directory names

vim.opt.splitright = true                        -- force all vertical splits to go to the right of current window
vim.opt.splitbelow = true                        -- force all horizontal splits to go below current window
vim.opt.laststatus = 3                           -- Global statusline when on split

-- vim.g.markdown_recommended_style = 0             -- Disable default markdown styles (see https://www.reddit.com/r/neovim/comments/z2lhyz/comment/ixjb7je)
-- vim.opt.list = true
-- vim.opt.listchars = 'eol:↲'
-- vim.opt.colorcolumn = "80,120"

-- vim.opt_local.colorcolumn = "80"
-- vim.opt_local.textwidth = 80
-- vim.opt_local.spell = true
-- vim.opt_local.linebreak = true
-- vim.opt_local.spelllang = "en"
-- vim.opt_local.concealcursor = "nv"
-- vim.opt_local.formatoptions = "tcqjn"
-- vim.opt_local.formatlistpat = "^\\s*\\([~]\\+\\|[-]\\+\\)\\s*"
vim.opt.autoread = true
vim.opt.autochdir = true

-- vim.opt_local.spell = true
-- vim.opt_local.spelllang = 'en'

-- vim.opt.grepprg = "rg --vimgrep"
-- vim.opt.grepformat = "%f:%l:%c:%m"
vim.g.have_nerd_font = true
--
--

-- sync buffers automatically
vim.opt.autoread = true
-- disable neovim generating a swapfile and showing the error
vim.opt.swapfile = false
-- vim.opt.virtualedit = "all"
-- vim.opt_local.wrap = false

-- vim.wo.wrap = false          -- Display long lines as just one line
vim.wo.linebreak = true
vim.wo.list = false

-- This might replace nvim-ufo
-- https://www.reddit.com/r/neovim/comments/1gi7ush/treesitter_is_amazing/
-- vim.o.foldmethod = 'syntax'
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'


-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod = 'manual'
