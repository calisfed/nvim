return {
	enabled = false,
	lazy = true,
	'renerocksai/telekasten.nvim',
	dependencies = {
		'nvim-telescope/telescope.nvim',
		'nvim-telekasten/calendar-vim'
	},
	keys = {
		{ "<leader>nf", "<cmd>Telekasten find_notes<cr>", desc = "Telekasten find notes" }
	},
	opts = function()
		require('telekasten').setup({
			home = vim.fn.expand("~/zette"),
		})
		vim.keymap.set("n", "<leader>np", "<cmd>Telekasten panel<cr>", { silent = true, desc = "Telekasten panel" })
		vim.keymap.set("n", "<leader>nf", "<cmd>Telekasten find_notes<cr>", { silent = true, desc = "Telekasten find notes" })
		vim.keymap.set("n", "<leader>nt", "<cmd>Telekasten show_tags<cr>", { silent = true, desc = "Telekasten show tags" })
		vim.keymap.set("n", "<leader>ng", "<cmd>Telekasten search_notes<cr>", { silent = true, desc = "Telekasten grep notes" })
		vim.keymap.set("n", "<leader>nc", "<cmd>Telekasten show_calendar<cr>", { silent = true, desc = "Telekasten calendar" })
	end
}
