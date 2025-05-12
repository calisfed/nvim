return
	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			-- NOTE: under dependencies are for lazy loading
			"3rd/image.nvim",
			'jbyuki/nabla.nvim'
		},
		enabled = false,
		lazy = true,     -- Recommended
		ft = "markdown", -- If you decide to lazy-load anyway
		opts = {
			preview = {
				icon_provider = "devicons" -- internal devicons mini
			}
		}
	}
