return {
	'aaronik/treewalker.nvim',
	enable = false,
	lazy = true,

	-- The following options are the defaults.
	-- Treewalker aims for sane defaults, so these are each individually optional,
	-- and setup() does not need to be called, so the whole opts block is optional as well.
	keys = {
		{"<C-k>", "<cmd>Treewalker Up<cr>", desc = "Treewalker up"},
		{"<C-j>", "<cmd>Treewalker Down<cr>", desc = "Treewalker down"}
	},
	opts =function ()

		require('treewalker').setup({

			-- Whether to briefly highlight the node after jumping to it
			highlight = true,

			-- How long should above highlight last (in ms)
			highlight_duration = 250,

			-- The color of the above highlight. Must be a valid vim highlight group.
			-- (see :h highlight-group for options)
			highlight_group = 'CursorLine',
		})

		-- movement
		vim.keymap.set({ 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<cr>', { silent = true, desc = "Treewalker up" })
		vim.keymap.set({ 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<cr>', { silent = true , desc = "Treewalker down"})
		vim.keymap.set({ 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<cr>', { silent = true , desc = "Treewalker left"})
		vim.keymap.set({ 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<cr>', { silent = true , desc = "Treewalker right"})

		-- swapping
		vim.keymap.set('n', '<C-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true , desc = "Treewalker swap up"})
		vim.keymap.set('n', '<C-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true , desc = "Treewalker swap down"})
		vim.keymap.set('n', '<C-S-h>', '<cmd>Treewalker SwapLeft<cr>', { silent = true , desc = "Treewalker swap left"})
		vim.keymap.set('n', '<C-S-l>', '<cmd>Treewalker SwapRight<cr>', { silent = true , desc = "Treewalker swap right"})

	end
}
