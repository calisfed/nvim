vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	defaults = {
		lazy = true,
	},
	spec = {
		{ import = "color" },
		{ import = "plug" },
		{ import = "configPlugins" },
	},
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true,        -- get a notification when new updates are found
		frequency = 3600,     -- check for updates every hour
		check_pinned = false, -- check for pinned packages that can't be updated
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[]
			paths = {
			}, -- add any custom paths here that you want to includes in the rtp
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	}
})

require 'options'
require 'autocmds'
require 'keymaps'
require('cool.quickfix')
require('cool.close_qf_with_q')
-- require('personal.nvim-treesitter-asciidoc.plugin')
require("nvim-treesitter.parsers").get_parser_configs().asciidoc = {
  install_info = {
    url = "https://github.com/cathaysia/tree-sitter-asciidoc",
    files = {
			"tree-sitter-asciidoc/src/parser.c",
			"tree-sitter-asciidoc/src/scanner.c",
			"tree-sitter-asciidoc_inline/src/parser.c",
			"tree-sitter-asciidoc_inline/src/scanner.c",
    },
    branch = "master",
  },
}

