return {
	"eldritch-theme/eldritch.nvim",
	lazy = false,
	config = function()
		require("eldritch").setup({
			palette = "darker",
			transparent = false,
			terminal_colors = true,
			styles = {
				comments  = { italic = true },
				keywords  = { italic = false },
				functions = { bold   = false, italic = true },
				variables = { bold   = true, italic = false },
				sidebars  = "dark", -- dark, normal
				floats    = "dark",
			},
			-- on_colors = function(colors)
			-- 	colors.bg = "#261C38"
			-- end
		})
		-- vim.cmd.colorscheme 'eldritch'
		vim.cmd.highlight 'LineNr term=bold cterm=NONE ctermfg=White ctermbg=NONE gui=NONE guifg=#a0a0a0 guibg=NONE'
		-- vim.cmd.highlight 'LineNr guifg=#a0a0a0'
		-- vim.cmd.highlight 'MatchParen guibg=inverse'
		-- autocmd BufEnter * hi MatchParen guibg=inverse
		vim.cmd.colorscheme 'eldritch-dark'
	end
}
