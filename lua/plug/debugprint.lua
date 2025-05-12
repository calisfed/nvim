return {
	enabled = false,
	'andrewferrier/debugprint.nvim',
	-- opts = { … },
	dependencies = {
		'echasnovski/mini.nvim',            -- Needed for :ToggleCommentDebugPrints(NeoVim 0.9 only) and line highlighting (optional)
		-- "ibhagwan/fzf-lua",                 -- Optional: If you want to use the :SearchDebugPrints command with fzf-lua
		"nvim-telescope/telescope.nvim"     -- Optional: If you want to use the :SearchDebugPrints command with telescope.nvim
	},
	-- event = "VeryLazy",
	-- lazy = false,  -- Required to make line highlighting work before debugprint is first used
	version = '*', -- Remove if you DON'T want to use the stable version
	keys = {
		{"<leader>tD", "<cmd>lua require'debugprint'.setup()<cr>",desc = "Enable debugprint"}
	},
	opts = function()
		require('debugprint').setup({
			keymaps = {
				normal = {
					plain_below = "g?p",
					plain_above = "g?P",
					variable_below = "g?v",
					variable_above = "g?V",
					variable_below_alwaysprompt = "",
					variable_above_alwaysprompt = "",
					surround_plain = "g?sp",
					surround_variable = "g?sv",
					surround_variable_alwaysprompt = "",
					textobj_below = "g?o",
					textobj_above = "g?O",
					textobj_surround = "g?so",
					toggle_comment_debug_prints = "",
					delete_debug_prints = "",
				},
				insert = {
					plain = "<C-G>p",
					variable = "<C-G>v",
				},
				visual = {
					variable_below = "g?v",
					variable_above = "g?V",
				},
			},
			commands = {
				toggle_comment_debug_prints = "ToggleCommentDebugPrints",
				delete_debug_prints = "DeleteDebugPrints",
				reset_debug_prints_counter = "ResetDebugPrintsCounter",
				search_debug_prints = "SearchDebugPrints",
			},
			-- … Other options
		})
	end
}
