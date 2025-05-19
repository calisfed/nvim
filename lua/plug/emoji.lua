return {
	enabled = false,
	"allaman/emoji.nvim",
	version = "1.0.0", -- optionally pin to a tag
	ft = "markdown",   -- adjust to your needs
	-- keys = {
	-- 	{'<leader>se', require('telescope').load_extension'emoji'.emoji, desc = 'Search Emoji' }
	-- },
	dependencies = {
		-- util for handling paths
		"nvim-lua/plenary.nvim",
		-- optional for nvim-cmp integration
		-- "hrsh7th/nvim-cmp",
		-- optional for telescope integration
		"nvim-telescope/telescope.nvim",
		-- optional for fzf-lua integration via vim.ui.select
		-- "ibhagwan/fzf-lua",
		-- {
		-- 	"saghen/blink.cmp",
		-- 	optional = true,
		-- 	opts = {
		-- 		sources = {
		-- 			default = { "emoji" },
		-- 			providers = {
		-- 				emoji = {
		-- 					name = "emoji",
		-- 					module = "blink.compat.source",
		-- 					-- overwrite kind of suggestion
		-- 					transform_items = function(ctx, items)
		-- 						local kind = require("blink.cmp.types").CompletionItemKind.Text
		-- 						for i = 1, #items do
		-- 							items[i].kind = kind
		-- 						end
		-- 						return items
		-- 					end,
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- }
	},
	opts = {
		-- default is false, also needed for blink.cmp integration!
		-- enable_cmp_integration = true,
		-- optional if your plugin installation directory
		-- is not vim.fn.stdpath("data") .. "/lazy/
		-- plugin_path = vim.fn.expand("$HOME/plugins/"),
	},
	config = function(_, opts)
		require("emoji").setup(opts)
		-- optional for telescope integration
		local ts = require('telescope').load_extension 'emoji'
		vim.keymap.set('n', '<leader>se', ts.emoji, { desc = '[S]earch [E]moji' })
	end,
}
