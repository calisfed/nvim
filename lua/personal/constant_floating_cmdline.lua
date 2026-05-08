
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cmd",
	callback = function()
		local ui2 = require("vim._core.ui2")
		vim.schedule(function()
			local win = ui2.wins and ui2.wins.cmd
			if win and vim.api.nvim_win_is_valid(win) then
				local win_config = vim.api.nvim_win_get_config(win)
				local width = win_config.width or math.floor(vim.o.columns * 0.6)
				local height = win_config.height or 1
				local row = (vim.o.lines - height) / 2
				local col = (vim.o.columns - width) / 2
				pcall(vim.api.nvim_win_set_config, win, {
					relative = "editor",
					row = row,
					col = col,
					width = width,
					height = height,
					anchor = "NW",
          style = 'minimal',
					border = "none",
                    style = "minimal"
				})
			end
		end)
	end,
})
