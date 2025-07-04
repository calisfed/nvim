return {

    enabled = false,
	"jbyuki/nabla.nvim",
	dependencies = {
		-- "nvim-neo-tree/neo-tree.nvim",
		"williamboman/mason.nvim",
	},
	lazy = true,

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "latex" },
			auto_install = true,
			sync_install = false,
		})
	end,

	keys = {
			{ "<leader>nm", ':lua require("nabla").popup()<cr>', desc = "Nabla popup", },
			{ "<leader>nM", ':lua require("nabla").enable_virt()<cr>', desc = "Nabla virt lines", },
			-- require"nabla".enable_virt({
			--   autogen = true, -- auto-regenerate ASCII art when exiting insert mode
			--   silent = true,     -- silents error messages
			-- })
}}
