vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.splitright = true
vim.o.splitbelow = true
vim.ui.progress_status()
vim.g.suda_smart_edit = 1
vim.o.cmdheight = 1
vim.o.cmdwinheight = 1
vim.o.foldmethod = 'manual'
vim.o.clipboard = "unnamedplus"
vim.opt.guicursor = 'n-v-c:block,i-ci-ve:ver100/,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'
vim.opt.cursorline = true -- highlight the current line
vim.opt.cursorlineopt = "screenline"
vim.opt.cursorcolumn = true
-- vim.cmd 'set fo-=1tcro'       -- :help fo-table
require("vim._core.ui2").enable({ enable = true, msg = { target = "msg" }, cmd = { height = 0.5 } })


vim.keymap.set("n", "<leader>w", "<cmd>update<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>")
-- vim.keymap.set("n", "<leader>=", "<cmd>lua vim.lsp.buf.format()<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>")

-- get the full path to your config directory
local config_path = vim.fn.stdpath("config") .. "/?.lua"
local config_subdirs = vim.fn.stdpath("config") .. "/?/init.lua"
package.path = package.path .. ";" .. config_path .. ";" .. config_subdirs


require("personal.cmd").setup({}) -- Make cmd a buffer so it can work in normal mode
vim.keymap.set("n", "<leader>zz", function() require("personal.zoom").zoom() end, { desc = "Zoom and Focus" })
-- vim.pack.add({ "https://github.com/lambdalisue/suda.vim" })        -- auto read/write file with sudo
vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" }) -- icons
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })


vim.pack.add({ "https://github.com/eldritch-theme/eldritch.nvim" })
require("eldritch").setup()
vim.cmd("colorscheme eldritch-dark")

vim.pack.add({ "https://github.com/rachartier/tiny-code-action.nvim" })       -- require telescope/fzf for code actions
vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" }) -- inline diagnostic
require("tiny-code-action").setup({})
require("tiny-inline-diagnostic").setup()
vim.keymap.set("n", "<leader>ca", function() require("tiny-code-action").code_action({}) end,
	{ noremap = true, silent = true, desc = "code action" })




vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("configs.oil")



vim.pack.add({ "https://github.com/b0o/incline.nvim" }) -- floatting file name


vim.pack.add({ "https://github.com/kdheepak/lazygit.nvim" }) -- git integration
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

vim.pack.add({ "https://github.com/sunnytamang/select-undo.nvim" })
require("select-undo").setup()


vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })
require("configs.mini")


-- source '$home/.config/nvim/lua/configs/mini.lua'

-- vim.pack.add({ "https://github.com/tpope/vim-fugitive" })


vim.pack.add({ "https://github.com/chaoren/vim-wordmotion" })
vim.g.wordmotion_spaces = ';|{}()[]'
vim.g.wordmotion_uppercase_spaces = ',;.'

-- vim.pack.add({ 'https://github.com/mikavilpas/yazi.nvim' })




vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client --[[@cast -?]]
		    :supports_method("textdocument/completion") then
			vim.lsp.completion.enable(
				true,
				client --[[@cast -?]]
				.id,
				ev.buf, { autotrigger = true }
			)
		end
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
			-- autotrigger = true,
			-- optional formating of items
			convert = function(item)
				-- remove leading misc chars for abbr name,
				-- and cap field to 25 chars
				-- local abbr = item.label
				-- abbr = abbr:match("[%w_.]+.*") or abbr
				-- abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr
				--
				-- remove return value
				-- local menu = ""

				-- only show abbr name, remove leading misc chars (bullets etc.),
				-- and cap field to 15 chars
				local abbr = item.label
				abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
				abbr = abbr:match("[%w_.]+.*") or abbr
				abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

				-- cap return value field to 15 chars
				local menu = item.detail or ""
				menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

				local labeldetails = {}

				-- -- print
				-- -- vim.api.nvim_win_cal
				-- if item.kind == 3 then
				-- abbr = 'f: ' .. abbr
				-- end

				return { abbr = abbr, menu = menu, labeldetails = labeldetails }
			end
		})
	end
})
vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" }
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		-- "lua_ls",
		-- "emmylua_ls",
		"clangd",
		"ty",
		"bashls",
		-- "tinymist"
	},
	automatic_enable = true
})

vim.o.complete = ".,o"                       -- use buffer and omnifunc
vim.o.completeopt = "fuzzy,menuone,noinsert" -- ,preselect" -- add 'popup' for docs (sometimes)
-- vim.o.autocomplete = true
vim.o.pumheight = 10
vim.o.pummaxwidth = 40
vim.o.pumborder = "rounded"

require("autocmds")
require("keymaps")
-- require("options")

vim.api.nvim_command("packadd nvim.undotree")

-- vim.lsp.config.emmylua_ls = {
--   cmd = { "emmylua_ls" },
--   root_markers = { ".emmyrc.json", ".git" },
--   filetypes = { "lua" },
--   settings = {
--     emmylua = {
--       format = {
--         enable = true,
--         defaultconfig = { max_line_length = "200" }
--       },
--       -- runtime = { version = "luajit" },
--       workspace = {
--         checkthirdparty = true,
--         library = {
--           "${3rd}/luv/library",
--           vim.env.vimruntime,
--           -- unpack(vim.api.nvim_get_runtime_file('', true)),
--           -- "/usr/share/awesome/lib",
--           -- for lsp settings type annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
--           -- vim.api.nvim_get_runtime_file('lua/lspconfig', false)[1],
--           vim.api.nvim_get_runtime_file('lua/lspconfig', false)[1],
--         },
--         -- library = vim.api.nvim_get_runtime_file('', true),
--       },
--       completion = { callsnippet = "replace" },
--       diagnostics = {
--         disable = { "missing-fields" },
--         globals = { "vim", "awesome", "client", "root", "screen", "mouse" }
--       }
--     }
--   }
-- }


vim.lsp.config.lua_ls = {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
			    path ~= vim.fn.stdpath('config')
			    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- tell the language server which version of lua you're using (most
				-- likely luajit in the case of neovim)
				version = 'LuaJIT',
				-- tell the language server how to find lua modules same way as neovim
				-- (see `:h lua-module-load`)
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			-- make the server aware of neovim runtime files
			workspace = {
				checkthirdparty = false,
				library = {
					vim.env.vimruntime,
					-- for lsp settings type annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
					-- vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
					vim.api.nvim_get_runtime_file('', true),
				},
				-- or pull in all of 'runtimepath'.
				-- note: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- see https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = vim.api.nvim_get_runtime_file('', true),
			},
		})
	end,
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultconfig = { max_line_length = "200" }
			},
			-- runtime = { version = "luajit" },
			completion = { callsnippet = "replace" },
			diagnostics = {
				disable = { "missing-fields" },
				globals = { "vim", "awesome", "client", "root", "screen", "mouse" }
			}
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
		"--header-insertion=iwyu" -- never
		-- "--cross-file-rename", --obsolete flag, no longer in used
	},
	-- filetypes = { "c" },
	init_options = {
		clangdfilestatus = true, -- provides information about activity on clangd’s per-file worker thread
		useplaceholders = true,
		completeunimported = true,
		semantichighlighting = true
	}
}

vim.lsp.config.tinymist = {
	-- https://github.com/myriad-dreamin/tinymist/blob/main/editors/vscode/configuration.md
	settings = {
		-- exporttarget = "html",
		exportpdf = "ontype",
		outputpath = "$root/target/$dir/$name"
	}
}

vim.lsp.config.bashls = { cmd = { "bash-language-server", "start" }, filetypes = { "sh", "zsh" } }
vim.lsp.enable({ "emmylua_ls", "zls", "clangd", "bashls", "tinymist" })

-- vim.lsp.inlay_hint.enable()









vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }
})
require("nvim-treesitter").install({ "lua" })
vim.api.nvim_create_autocmd("filetype", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end
})



vim.pack.add({ "https://github.com/onsails/lspkind.nvim" })
require("lspkind").setup({ mode = "symbol" })


vim.pack.add({ "https://github.com/aserowy/tmux.nvim" })
require("tmux").setup({
	copy_sync = {
		-- enables copy sync. by default, all registers are synchronized.
		-- to control which registers are synced, see the `sync_*` options.
		enable = true,
		-- ignore specific tmux buffers e.g. buffer0 = true to ignore the
		-- first buffer or named_buffer_name = true to ignore a named tmux
		-- buffer with name named_buffer_name :)
		ignore_buffers = { empty = false },
		-- tmux >= 3.2: all yanks (and deletes) will get redirected to system
		-- clipboard by tmux
		redirect_to_clipboard = false,
		-- offset controls where register sync starts
		-- e.g. offset 2 lets registers 0 and 1 untouched
		register_offset = 0,
		-- overwrites vim.g.clipboard to redirect * and + to the system
		-- clipboard using tmux. if you sync your system clipboard without tmux,
		-- disable this option!
		sync_clipboard = false,
		-- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
		sync_registers = true,
		-- synchronizes registers when pressing p and p.
		sync_registers_keymap_put = true,
		-- synchronizes registers when pressing (c-r) and ".
		sync_registers_keymap_reg = true,
		-- syncs deletes with tmux clipboard as well, it is adviced to
		-- do so. nvim does not allow syncing registers 0 and 1 without
		-- overwriting the unnamed register. thus, ddp would not be possible.
		sync_deletes = true,
		-- syncs the unnamed register with the first buffer entry from tmux.
		sync_unnamed = true
	},
	navigation = {
		-- cycles to opposite pane while navigating into the border
		cycle_navigation = true,
		-- enables default keybindings (c-hjkl) for normal mode
		enable_default_keybindings = true,
		-- prevents unzoom tmux when navigating beyond vim border
		persist_zoom = false
	},
	resize = {
		-- enables default keybindings (a-hjkl) for normal mode
		enable_default_keybindings = true,
		-- sets resize steps for x axis
		resize_step_x = 1,
		-- sets resize steps for y axis
		resize_step_y = 1
	},
	swap = {
		-- cycles to opposite pane while navigating into the border
		cycle_navigation = true,
		-- enables default keybindings (c-a-hjkl) for normal mode
		enable_default_keybindings = true
	}
})

require"configs.dial"

local helpers = require("incline.helpers")
-- local devicons = require 'nvim-web-devicons'
local devicons = require("nvim-web-devicons")
require("incline").setup({
	window = {
		padding = 0,
		margin = { horizontal = 0 }
	},
	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		if filename == "" then
			filename = "[no name]"
		end
		local ft_icon, ft_color = devicons.get_icon_color(filename)
		local modified = vim.bo[props.buf].modified
		return {
			ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or
			"",
			" ",
			{ filename, gui = modified and "bold,italic" or "bold" },
			" ",
			guibg = "#44406e"
		}
	end
})

-- vim.pack.add({ "https://github.com/3rd/image.nvim" })
-- require("image").setup({
--   backend = "sixel",                                                                 -- or "ueberzug" or "sixel" or "kitty
--   processor = "magick_cli",                                                          -- or "magick_rock"
--   integrations = {
--     markdown = {
--       enabled = true,
--       clear_in_insert_mode = false,
--       download_remote_images = true,
--       only_render_image_at_cursor = false,
--       only_render_image_at_cursor_mode = "popup", -- or "inline"
--       floating_windows = false,                   -- if true, images will be rendered in floating markdown windows
--       filetypes = { "markdown", "vimwiki" }       -- markdown extensions (ie. quarto) can go here
--     },
--     asciidoc = {
--       enabled = true,
--       clear_in_insert_mode = false,
--       download_remote_images = true,
--       only_render_image_at_cursor = false,
--       only_render_image_at_cursor_mode = "popup",
--       floating_windows = false,
--       filetypes = { "asciidoc", "adoc" }
--     },
--     neorg = {
--       enabled = true,
--       filetypes = { "norg" }
--     },
--     rst = {
--       enabled = true
--     },
--     typst = {
--       enabled = true,
--       filetypes = { "typst" }
--     },
--     html = {
--       enabled = false
--     },
--     css = {
--       enabled = false
--     }
--   },
--   max_width = nil,
--   max_height = nil,
--   max_width_window_percentage = nil,
--   max_height_window_percentage = 50,
--   scale_factor = 1.0,
--   window_overlap_clear_enabled = false,                                              -- toggles images when windows are overlapped
--   window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
--   editor_only_render_when_focused = false,                                           -- auto show/hide images when the editor gains/looses focus
--   tmux_show_only_in_active_window = false,                                           -- auto show/hide images in the correct tmux window (needs visual-activity off)
--   hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" } -- render image files as images when opened
-- })


vim.pack.add({ "https://github.com/tjgao/quickbuf.nvim" })
require("quickbuf").setup()
vim.keymap.set("n", "<leader><leader>", "<cmd>QuickBuf<cr>", { desc = "quick change buffers" })



























-- todo: check these
-- cool thing to test
-- https://www.reddit.com/r/neovim/comments/1t4tm9m/plugin_atlasnvim_v020_github_jira_inside_neovim/ -- github and jira
-- https://github.com/romus204/tree-sitter-manager.nvim?tab=readme-ov-file -- alternative for nvim-treesitter
-- https://www.reddit.com/r/neovim/comments/1r4tho1/refernvim_a_picker_that_doesnt_get_in_your_way/ -- picker using vim ui
-- https://www.reddit.com/r/neovim/comments/1t8ljkp/zealnvim/ -- zeal, document management
-- https://github.com/ggml-org/whisper.cpp -- audio transcription

-- https://github.com/SeniorMars/typst.nvim -- typst treesitter
-- https://github.com/2KAbhishek/homegrown.nvim -- small stuff combined
-- https://github.com/atiladefreitas/dooing -- new UI

-- TODO: get a spell checker
-- typos, harper,..
-- https://github.com/chaneyzorn/spellwand.nvim#limitations -- spell checker


-- QoL
-- https://github.com/owen-dechow/videre.nvim -- json, yaml,... explorer


-- Some ideas
-- https://github.com/syntaxpresso/bufstate.nvim -- workspace management, kindla tmux but nvim


-- vim.pack.add({"https://github.com/simifalaye/minibuffer.nvim"})
-- local minibuffer = require("minibuffer")
-- vim.ui.select = require("minibuffer.builtin.ui_select")
-- vim.ui.input = require("minibuffer.builtin.ui_input")
-- vim.keymap.set("n", "<leader><CR>", function()
--   minibuffer.resume(true)
-- end)

-- vim.keymap.set("n","<leader>;","<esc>q:i")
-- vim.keymap.set("n",":","<cmd>source " .. vim.fn.stdpath('config') .."/cmdline.lua<cr>")

-- Paste image
vim.pack.add({ "https://github.com/hakonharnes/img-clip.nvim" })
require('img-clip').setup()
vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>")


-- Markdown view
vim.pack.add({ "https://github.com/noisesfromspace/touchup.nvim" })
require("touchup").setup({
	bullets = { enabled = true, icons = { "✸", "✿", "✦", "✧" } },
	checkboxes = { enabled = true },
	code_blocks = { enabled = true },
	markers = { enabled = true },
	quotes = { enabled = true },
	enter = { enabled = true },
})


require("configs.dap")
