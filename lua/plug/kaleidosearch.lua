return {
	enabled = false,
	"hamidi-dev/kaleidosearch.nvim",
	dependencies = {
		-- "tpope/vim-repeat",       -- optional for dot-repeatability
		-- "stevearc/dressing.nvim", -- optional for nice input
	},
	lazy = true,
	keys = {
		{ "<leader>sCs", "<cmd>Kaleidosearch<cr>", desc = "Color word" },
		{ "<leader>sCc", "<cmd>KaleidosearchClear<cr>", desc = "Color word clear" },
		{ "<leader>sCn", "<cmd>KaleidosearchAddWord<cr>", desc = "Color word add more" },
		{ "<leader>sCa", "<cmd>KaleidosearchToggleCursorWord<cr>", desc = "Color word add cword" },
	},
	config = function()
		require("kaleidosearch").setup({
			highlight_group_prefix = "WordColor_", -- Prefix for highlight groups
			case_sensitive = false,             -- Case sensitivity for matching
			keymaps = {
				enabled = false,                   -- Set to false to disable default keymaps
				open = "<leader>Cs",              -- Open input prompt for search
				clear = "<leader>Cc",             -- Clear highlights (reset to clean slate)
				add_new_word = "<leader>Cn",      -- Add a new word to existing highlights
				add_cursor_word = "<leader>Ca",   -- Add word under cursor to highlights OR current visual selection
				opts = {
					noremap = true,
					silent = true,
				}
			}
		})
	end,
}
