
local M = {}

-- Function to display data in a read-only buffer
 M.display_in_readonly_buffer = function(data)
	-- Create a new empty buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- Set the content of the buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(data, '\n'))

	-- Open the buffer in a new window
	vim.api.nvim_set_current_buf(buf)
	-- Set buffer options to make it read-only
	vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
	vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
	vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
	vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
	vim.api.nvim_set_option_value('readonly', true, { buf = buf })
end

-- Wrapper function to get data and display it
-- local function show_data_in_buffer(table)
-- 	local data = vim.inspect(table)
-- 	display_in_readonly_buffer(data)
-- end
--
-- -- Expose the function globally
-- _G.P = show_data_in_buffer
-- vim.api.nvim_create_user_command('ShowData', function()
-- 	show_data_in_buffer()
-- end, {})
--
--
-- --- @param table table
-- --- @return table
-- _G.p = function(table)
-- 	print(vim.inspect(table))
-- 	return table
-- end
--
--
-- _G.change_checkbox_md = function()
-- 	local key = string.char(vim.fn.getchar())
-- 	local cmd = '<Esc>mm0f[wr' .. key .. '<Esc>`m'
-- 	vim.api.nvim_input(cmd)
-- end

M.msf = function ()
	local buf_list = vim.api.nvim_list_bufs()
	print(vim.inspect(buf_list))
	-- print(buf_list[1])


		-- require('mini.starter').setup({
		-- 	query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_.',
		-- 	autoopen = true,
		-- 	evaluate_single = true,
		-- 	items = {
		-- 	{}
		-- 	},
		-- 	footer = '',
		-- 	content_hooks = {
		-- 		require 'mini.starter'.gen_hook.adding_bullet('  ', true),
		-- 		require 'mini.starter'.gen_hook.indexing('all', { 'Commands', 'Sessions' }),
		-- 		-- require'mini.starter'.gen_hook.padding(3, 2),
		-- 		require('mini.starter').gen_hook.aligning('center', 'center'),
		-- 	},
		-- 	-- Whether to disable showing non-error feedback
		-- 	silent = false,
		--
		-- })
end


-- vim.keymap.set("n", "<leader>x", change_checkbox_md)
return M
