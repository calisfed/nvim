return {
	{
		"folke/lazydev.nvim",
		enabled = false,
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Library paths can be absolute
				-- "~/projects/my-awesome-lib",
				-- Or relative, which means they will be resolved from the plugin dir.
				"lazy.nvim",
				"luvit-meta/library",
				-- It can also be a table with trigger words / mods
				-- Only load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library",        words = { "vim%.uv" } },
				-- always load the LazyVim library
				-- "LazyVim",
				-- Only load the lazyvim library when the `LazyVim` global is found
				{ path = "LazyVim",                   words = { "LazyVim" } },
				-- Load the wezterm types when the `wezterm` module is required
				-- Needs `justinsgithub/wezterm-types` to be installed
				{ path = "wezterm-types",             mods = { "wezterm" } },
				-- Load the xmake types when opening file named `xmake.lua`
				-- Needs `LelouchHe/xmake-luals-addon` to be installed
				-- { path = "xmake-luals-addon/library", files = { "xmake.lua" } },

				library = { plugins = { "nvim-dap-ui" }, types = true },

				'${3rd}/luv/library',
				unpack(vim.api.nvim_get_runtime_file('', true)),
			},
			-- always enable unless `vim.g.lazydev_enabled = false`
			-- This is the default
			enabled = function(root_dir)
				return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
			end,
			-- disable when a .luarc.json file is found
			-- enabled = function(root_dir)
			--   return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
			-- end,
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	-- {                                       -- optional cmp completion source for require statements and module annotations
	-- 	"hrsh7th/nvim-cmp",
	-- 	opts = function(_, opts)
	-- 		opts.sources = opts.sources or {}
	-- 		table.insert(opts.sources, {
	-- 			name = "lazydev",
	-- 			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
	-- 		})
	-- 	end,
	-- },
	{ -- optional blink completion source for require statements and module annotations
		"saghen/blink.cmp",
		opts = {
			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},
	{ "folke/neodev.nvim",    enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
