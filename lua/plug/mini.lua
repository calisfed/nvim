---@diagnostic disable: undefined-global
return { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    -- event = "VeryLazy",
    lazy = false,
    enabled = false,
    config = function()
        require('mini.surround').setup()
        require('mini.move').setup()
        require('mini.align').setup()
        require('mini.operators').setup({
            evaluate = { prefix = 'g=', },
            exchange = { prefix = "gX" },
            -- multiply = { prefix = "gm" },
            multiply = { prefix = "" },
            replace = { prefix = "" },
            sort = { prefix = "gs" },
        })
        -- require('mini.pairs').setup()
        -- require('mini.animate').setup({ scroll = { enable = false, } })
        -- require('mini.notify').setup()
        require('mini.splitjoin').setup()
        require('mini.test').setup()
        require('mini.trailspace').setup()
        require('mini.bracketed').setup()
        require('mini.cursorword').setup({ delay = 50, }) -- for some reason it didn't show
        vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', { underline = true })
        require('mini.misc').setup()
        vim.keymap.set({ 'n', 'v' }, "<leader>zz", "<cmd>lua require'mini.misc'.zoom()<cr>", { desc = "Zoom" })
        require('mini.icons').setup({ style = 'glyph', file = { ['init.lua'] = { glyph = ' ' }, }, })
        require('mini.extra').setup()

        local spec = require('mini.ai').gen_spec
        require('mini.ai').setup {
            n_lines = 500,
            custom_textobjects = {
                ['*'] = spec.pair('*', '*', { type = 'greedy' }),
                ['_'] = spec.pair('_', '_', { type = 'greedy' }),
                ['|'] = spec.pair('|', '|', { type = 'greedy' }),
                ['v'] = spec.pair('|', '|', { type = 'greedy' }),
                F = spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                o = spec.treesitter({
                    a = { '@conditional.outer', '@loop.outer' },
                    i = { '@conditional.inner', '@loop.inner' },
                })
            },
            mappings = {
                -- Main textobject prefixes
                around = 'a',
                inside = 'i',

                -- Next/last textobjects
                around_next = 'an',
                inside_next = 'in',
                around_last = 'al',
                inside_last = 'il',

                -- Move cursor to corresponding edge of `a` textobject
                goto_left = 'g[',
                goto_right = 'g]',
            },
        }

        require('mini.clue').setup({
            triggers = {
                -- Leader triggers
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g` key
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },

                -- Marks
                { mode = 'n', keys = "'" },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = "'" },
                { mode = 'x', keys = '`' },

                -- Registers
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z` key
                { mode = 'n', keys = 'z' },
                { mode = 'x', keys = 'z' },

                -- Moving around
                { mode = 'n', keys = '[' },
                { mode = 'n', keys = ']' },


            },

            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                require 'mini.clue'.gen_clues.builtin_completion(),
                require 'mini.clue'.gen_clues.g(),
                require 'mini.clue'.gen_clues.marks(),
                require 'mini.clue'.gen_clues.registers(),
                require 'mini.clue'.gen_clues.windows(),
                require 'mini.clue'.gen_clues.z(),

                { mode = 'n', keys = '<leader>c',  desc = '+Code' },
                { mode = 'n', keys = '<leader>cg', desc = '+Goto' },
                { mode = 'n', keys = '<leader>g',  desc = '+Git/Go' },
                { mode = 'n', keys = '<leader>n',  desc = '+Notes' },
                { mode = 'n', keys = '<leader>s',  desc = '+Searchs' },
                { mode = 'n', keys = '<leader>sC', desc = '+Colors' },
                { mode = 'n', keys = '<leader>sW', desc = '+Dict' },
                { mode = 'n', keys = '<leader>t',  desc = '+Toggle' },

                { mode = 'n', keys = '<C-w>',      desc = '+Window' },

                -- `z` key
                { mode = 'n', keys = 'z',          desc = '+Folds' },
                { mode = 'x', keys = 'z',          desc = '+Folds' },

                -- Moving around
                { mode = 'n', keys = '[',          desc = '->Next' },
                { mode = 'n', keys = ']',          desc = '<-Prev' },
            },
            window = {
                delay = 200,
            }
        })

        require('mini.statusline').setup(
            {
                -- Content of statusline as functions which return statusline string. See
                -- `:h statusline` and code of default contents (used instead of `nil`).
                content = {
                    -- Content for active window
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local git           = MiniStatusline.section_git({ trunc_width = 40 })
                        local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
                        local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                        local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
                        local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
                        local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                        local location      = MiniStatusline.section_location({ trunc_width = 75 })
                        local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
                        local spell         = vim.wo.spell and (MiniStatusline.is_truncated(120) and 'S' or 'SPELL') or
                            ''
                        -- local clipboard = function ()
                        --
                        -- end

                        return MiniStatusline.combine_groups({
                            { hl = mode_hl,                 strings = { mode } },
                            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                            '%<', -- Mark general truncate point
                            { hl = mode_hl,                  strings = { spell } },
                            { hl = 'MiniStatuslineFilename', strings = { filename } },
                            '%=', -- End left alignment
                            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                            { hl = mode_hl,                  strings = { search, location } },
                        })
                    end,
                    -- Content for inactive window(s)
                    inactive = nil,
                },
                -- Whether to use icons by default
                use_icons = true,
                -- Whether to set Vim's settings for statusline (make it always shown)
                set_vim_settings = true,
            }
        )



        ---@diagnostic disable-next-line: duplicate-set-field
        -- statusline.section_location = function()
        --   return ''
        -- end

        -- require('mini.indentscope').setup {
        --   symbol = '╎',
        --   options = { try_as_border = true },
        --   draw = {
        --     animation = function()
        --       return 0
        --     end,
        --   },
        -- }

        require('mini.comment').setup({
            options = {
                custom_commentstring = nil,
                ignore_blank_line = true,
                start_of_line = false,
                pad_comment_parts = true,
            },
            mappings = { comment = 'gc', comment_line = 'gcc', comment_visual = 'gc', textobject = 'gc', },
            hooks = { pre = function() end, post = function() end, },
        })






        require('mini.pick').setup(
            {
                window = {
                    config = function()
                        local height = math.floor(0.618 * vim.o.lines)
                        local width = math.floor(0.618 * vim.o.columns)
                        return {
                            anchor = 'NW',
                            height = height,
                            width = width,
                            row = math.floor(0.5 * (vim.o.lines - height)),
                            col = math.floor(0.5 * (vim.o.columns - width)),
                        }
                    end,
                    prompt_caret = '▏',
                    -- String to use as prefix in prompt
                    prompt_prefix = '> ',
                },
                -- source = {
                --   preview = function(buf_id, item, opts)
                --     print(vim.inspect(item))
                --     print(vim.inspect(opts))
                --     print(vim.inspect(buf_id))

                --     local bufnr = vim.api.nvim_create_buf(false, true)
                --     local winid = vim.api.nvim_open_win(bufnr, false, {
                --       style = 'minimal',
                --       relative = 'editor',
                --       width = 10,
                --       height = 10,
                --       row = 1,
                --       col = 1,
                --       title = 'preview'
                --     })
                --     vim.wo[winid].winhighlight = "Normal:Normal"
                --     require('mini.pick').default_preview(bufnr, item, opts)
                --     vim.api.nvim_create_autocmd('MiniPickStop', {
                --       callback = function()
                --         vim.api.nvim_win_close(winid, true)
                --         vim.api.nvim_buf_delete(bufnr, { force = true })
                --       end
                --     })
                --   end
                -- },
            }
        )
        vim.keymap.set('n', '<leader>sh', "<cmd>Pick help<cr>", { desc = 'Search Help' })
        vim.keymap.set('n', '<leader>sk', "<cmd>Pick keymaps<cr>", { desc = 'Search Keymaps' })
        vim.keymap.set('n', '<leader>sf',
            "<cmd>lua MiniPick.builtin.files({},{source = {cwd =require'personal.utils'.get_git_root()}})<cr>",
            { desc = 'Search Files' })
        vim.keymap.set('n', '<leader>sw',
            "<cmd>lua MiniPick.builtin.grep({},{source = {cwd =require'personal.utils'.get_git_root()}})<cr>",
            { desc = 'Grep current word' })
        vim.keymap.set('n', '<leader>sg',
            "<cmd>lua MiniPick.builtin.grep_live({},{source = {cwd =require'personal.utils'.get_git_root()}})<cr>",
            { desc = 'Live grep' })
        vim.keymap.set('n', '<leader>sb', "<cmd>Pick buffers<cr>", { desc = 'Search existing buffers' })
        vim.keymap.set('n', '<leader>sd', "<cmd>Pick diagnostic<cr>", { desc = 'Search Diagnostics' })
        vim.keymap.set('n', '<leader>sr', "<cmd>Pick resume<cr>", { desc = 'Search Resume' })
        vim.keymap.set('n', '<leader>s.', "<cmd>Pick oldfiles<cr>", { desc = 'Search Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader>sR', "<cmd>Pick lsp scope='references'<cr>", { desc = 'Search References' })
        vim.keymap.set('n', '<leader>sS', "<cmd>Pick lsp scope='workspace_symbol'<cr>",
            { desc = 'Search Workspace Symbol' })
        vim.keymap.set('n', '<leader>sI', "<cmd>Pick lsp scope='implementation'<cr>", { desc = 'Search Implementation' })
        vim.keymap.set('n', '<leader>ss', "<cmd>Pick lsp scope='document_symbol'<cr>",
            { desc = 'Search Document Symbol' })
        vim.keymap.set('n', '<leader>sD', "<cmd>Pick lsp scope='definition'<cr>", { desc = 'Search Definition' })
        vim.keymap.set('n', '<leader>sy', "<cmd>Pick lsp scope='declaration'<cr>", { desc = 'Search Declaration' })
        vim.keymap.set('n', '<leader>st', "<cmd>Pick lsp scope='type_definition'<cr>",
            { desc = 'Search Type definition' })

        local pick_man = function(local_opts, opts)
            local_opts = vim.tbl_deep_extend('force', { default_split = 'horizontal' }, local_opts or {})
            local default_modifier = ({ horizontal = '', vertical = 'vert ', tab = 'tab ' })[local_opts.default_split]
            if default_modifier == nil then
                error('(mini.pick) ' ..
                    '`opts.default_split` should be one of "horizontal", "vertical", "tab"', 0)
            end

            local man_buf = vim.api.nvim_create_buf(false, true)
            -- vim.bo[man_buf].buftype = 'help'

            local function get_man_pages()
                -- local output = vim.fn.systemlist("apropos .")
                local output = vim.fn.systemlist("man -k .")
                local items = {}

                for _, line in ipairs(output) do
                    -- local name, section, summary = line:match("^(%S+)%s+%(([%w]+)%)+%-%s+(.*)$")
                    local name, section, summary = line:match("^(%S+)%s+%((.-)%)%s+%-%s+(.*)$")
                    if name and section then
                        table.insert(items, {
                            name = name,
                            section = section,
                            cmd = string.format("%s %s", section, name),
                            filename = string.format("man://%s(%s)", name, section),
                            line = line,
                        })
                    end
                end
                return items
            end

            local man_pages = vim.api.nvim_buf_call(man_buf, function() return get_man_pages() end)
            vim.api.nvim_buf_delete(man_buf, { force = true })
            vim.tbl_map(function(t) t.text = t.line end, man_pages)

            local choose = function(item, modifier)
                if item == nil then return end
                vim.schedule(function()
                    vim.cmd((modifier or default_modifier) ..
                        'Man ' .. (item.cmd or ''))
                end)
            end
            local preview = function(buf_id, item)
                vim.api.nvim_buf_call(buf_id, function()
                    vim.cmd('edit ' .. vim.fn.fnameescape(item.filename))
                    vim.bo.buftype, vim.bo.buflisted, vim.bo.bufhidden = 'nofile', false, 'wipe'
                    local has_ts = pcall(vim.treesitter.start, 0)
                    if not has_ts then vim.bo.syntax = 'man' end
                    vim.cmd('normal! zt')
                end)
            end

            -- Modify default mappings to work with special `:help` command
            local map_custom = function(char, modifier)
                local f = function()
                    choose(MiniPick.get_picker_matches().current, modifier)
                    return true
                end
                return { char = char, func = f }
            end

            local config_mappings = vim.tbl_deep_extend('force', MiniPick.config, vim.b.minipick_config or {},
                config or {}).mappings
            --stylua: ignore
            local mappings = {
                choose_in_split = '',
                show_help_in_split = map_custom(config_mappings.choose_in_split, ''),
                choose_in_vsplit = '',
                show_help_in_vsplit = map_custom(config_mappings.choose_in_vsplit, 'vertical '),
                choose_in_tabpage = '',
                show_help_in_tabpage = map_custom(config_mappings.choose_in_tabpage, 'tab '),
            }

            local source = { items = man_pages, name = 'Man', choose = choose, preview = preview }
            opts = vim.tbl_deep_extend('force', { source = source, mappings = mappings }, opts or {})
            return MiniPick.start(opts)
        end

        vim.keymap.set('n', '<leader>sm', function() pick_man() end, { desc = "Search man pages" })
















        require('mini.sessions').setup( -- No need to copy this inside `setup()`. Will be used automatically.
            {
                -- Whether to read default session if Neovim opened without file arguments
                autoread = true,

                -- Whether to write currently read session before quitting Neovim
                autowrite = true,

                -- Directory where global sessions are stored (use `''` to disable)
                -- directory = --<"session" subdir of user data directory from |stdpath()|>,
                -- directory = vim.fn.stdpath('data') .. '/session',

                -- File for local session (use `''` to disable)
                file = 'Session.vim',

                -- Whether to force possibly harmful actions (meaning depends on function)
                force = { read = false, write = true, delete = false },

                -- Hook functions for actions. Default `nil` means 'do nothing'.
                hooks = {
                    -- Before successful action
                    pre = {
                        read = nil,
                        write = nil,
                        delete = nil
                    },
                    -- After successful action
                    post = { read = nil, write = nil, delete = nil },
                },

                -- Whether to print session path after action
                verbose = { read = false, write = true, delete = true },
            })
        -- local ss_ls = function()
        --   local detected = require("mini.sessions").detected
        --   local session_list = {}
        --   for i, ss in ipairs(detected) do
        --     ss.name = ss.name:gsub("%", "/")
        --   end
        -- end
        -- ss_ls()
        require('mini.starter').setup({
            query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_.',
            autoopen = true,
            evaluate_single = true,
            items = {
                -- require'mini.starter'.sections.telescope(),

                { name = 'Edit new buffer', action = 'enew',                                    section = 'Commands' },
                { name = 'Config Neovim',   action = 'Telescope find_files cwd=~/.config/nvim', section = 'Commands' },
                { name = 'Files in cwd',    action = 'Telescope find_files',                    section = 'Commands' },
                -- { name = 'Config Neovim',   action = ':lua MiniPick.builtin.files({},{source = {cwd = "~/.config/nvim/"}})',                     section = 'Commands' },
                -- { name = 'Files in cwd',    action = ':lua MiniPick.builtin.files({},{source = {cwd =require"personal.utils".get_git_root()}})', section = 'Commands' },
                -- { name = 'Recent file',     action = ':e#',                                                                                      section = 'Commands' },
                { name = 'Update plugins',  action = 'Lazy sync',                               section = 'Commands' },
                { name = 'Quit Neovim',     action = 'qall',                                    section = 'Commands' },
                require 'mini.starter'.sections.recent_files(3, true),
                -- require 'mini.starter'.sections.sessions(5, true),
                require 'mini.starter'.sections.recent_files(3, false),
            },
            header =
            [[
                                  
                                  ████ ██████           █████      ██
                                  ███████████             █████ 
                                  █████████ ███████████████████ ███   ███████████
                                  █████████  ███    █████████████ █████ ██████████████
                                  █████████ ██████████ █████████ █████ █████ ████ █████
                                  ███████████ ███    ███ █████████ █████ █████ ████ █████
                                  ██████  █████████████████████ ████ █████ █████ ████ ██████
                                  ]],

            -- dashboard.nvim reference
            footer = function()
                local quotes = require("fortune").get_fortune()
                local quote = ""
                for _, q in ipairs(quotes) do
                    quote = quote .. '\n' .. q
                end
                return quote
            end,
            content_hooks = {
                require 'mini.starter'.gen_hook.adding_bullet('  ', true),
                require 'mini.starter'.gen_hook.indexing('all', { 'Commands', 'Sessions' }),
                -- require'mini.starter'.gen_hook.padding(3, 2),
                require('mini.starter').gen_hook.aligning('center', 'center'),
            },
            -- Whether to disable showing non-error feedback
            silent = false,

        })



        -- require('mini.completion').setup({
        --   lsp_completion = {
        --     source_func = 'omnifunc',
        --   },
        --   delay = { completion = 0, info = 0, signature = 0 },
        --   window = {
        --     info = { height = 25, width = 80, border = 'single' },
        --     signature = { height = 25, width = 80, border = 'single' },
        --   },
        -- })

        -- vim.o.completeopt = 'menuone,noinsert' -- This option for mini.completion to work as my intended


        --
        --
        -- local gen_loader = require('mini.snippets').gen_loader
        --
        -- require('mini.snippets').setup({
        -- 	snippets = {
        -- 		-- Load custom file with global snippets first (adjust for Windows)
        -- 		gen_loader.from_file('~/.config/nvim/snippets/global.json'),
        --
        -- 		-- Load snippets based on current language by reading files from
        -- 		-- "snippets/" subdirectories from 'runtimepath' directories.
        -- 		gen_loader.from_lang(),
        -- 	},
        -- })


        require('mini.keymap').setup()
        local map_multistep = require('mini.keymap').map_multistep

        -- map_multistep('i', '<Tab>',   { 'pmenu_next' })
        -- map_multistep('i', '<Tab>', { 'pmenu_accept', 'minisnippets_next','vimsnippet_next','luasnip_next', 'minisnippets_expand', 'jump_after_close'})
        -- map_multistep('i', '<Tab>', { 'pmenu_accept', 'minisnippets_next','vimsnippet_next','luasnip_next', 'minisnippets_expand', 'jump_after_close'})
        -- map_multistep('i', '<C-l>', {'minisnippets_next', 'vimsnippet_next', 'luasnip_next'})
        -- map_multistep('i', '<C-h>', {'minisnippets_prev', 'vimsnippet_prev', 'luasnip_prev'})
        -- map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
        -- map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
        -- map_multistep('i', '<BS>', { 'minipairs_bs' })
        -- map_multistep('i', '<Tab>', {'blink_accept', 'jump_after_tsnode', 'jump_after_close'})

        local map_combo = require('mini.keymap').map_combo
        -- Support most common modes. This can also contain 't', but would
        -- only mean to press `<Esc>` inside terminal.
        local mode = { 'i', 'c', 'x', 's' }
        map_combo(mode, 'jk', '<BS><BS><Esc>')

        -- To not have to worry about the order of keys, also map "kj"
        map_combo(mode, 'kj', '<BS><BS><Esc>')

        -- Escape into Normal mode from Terminal mode
        map_combo('t', 'jk', '<BS><BS><C-\\><C-n>')
        map_combo('t', 'kj', '<BS><BS><C-\\><C-n>')

        -- local hipatterns = require('mini.hipatterns')
        -- hipatterns.setup({
        -- 	highlighters = {
        -- 		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        -- 		fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        -- 		hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        -- 		todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        -- 		note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- 		-- Highlight hex color strings (`#rrggbb`) using that color
        -- 		hex_color = hipatterns.gen_highlighter.hex_color(),
        -- 	},
        -- })

        -- Choose background and foreground
        -- this only work on Kitty and Ghostty
        -- require('mini.hues').setup( { background = '#11262d', foreground = '#c0c8cc', accent = 'blue', saturation= 'high', n_hues = 8, })
    end,

}
