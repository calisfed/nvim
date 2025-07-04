return {
	enabled = false,
	lazy = false,
	'nvimdev/lspsaga.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter',  'nvim-tree/nvim-web-devicons', },
	config = function()
		require('lspsaga').setup({
			enable = true,
			ui = { winbar_prefix = '', border = 'rounded', devicon = true, foldericon = true, title = true, expand = '⊞', collapse = '⊟', code_action = '💡', lines = { '┗', '┣', '┃', '━', '┏' }, kind = nil, button = { '', '' }, imp_sign = '󰳛 ', use_nerd = true, },
			hover = {max_width = 0.9, max_height = 0.8, open_link = 'gx', open_cmd = '!firefox', override_win_config = function (conf) conf.winblend = 0 return conf end,},
			diagnostic = { show_layout = 'float', show_normal_height = 10, jump_num_shortcut = true, auto_preview = false, max_width = 0.8, max_height = 0.6, max_show_width = 0.9, max_show_height = 0.6, wrap_long_lines = true, extend_relatedInformation = false, diagnostic_only_current = false, keys = { exec_action = 'o', quit = 'q', toggle_or_jump = '<CR>', quit_in_show = { 'q', '<ESC>' }, }, },
			code_action = { num_shortcut = true, show_server_name = false, extend_gitsigns = false, only_in_cursor = true, max_height = 0.3, cursorline = true, keys = { quit = 'q', exec = '<CR>', }, },
			lightbulb = { enable = true, sign = true, debounce = 10, sign_priority = 40, virtual_text = true, enable_in_insert = true, ignore = { clients = {}, ft = {}, }, },
			scroll_preview = { scroll_down = '<C-f>', scroll_up = '<C-b>', },
			request_timeout = 2000,
			finder = { max_height = 0.5, left_width = 0.4, methods = {}, default = 'def+ref+imp', layout = 'float', silent = false, filter = {}, fname_sub = nil, sp_inexist = false, sp_global = false, ly_botright = false, keys = { shuttle = '[w', toggle_or_open = 'o', vsplit = 's', split = 'i', tabe = 't', tabnew = 'r', quit = 'q', close = '<C-c>k', }, },
			definition = { width = 0.6, height = 0.5, save_pos = false, keys = { edit = '<C-o>', vsplit = '<C-v>', split = '<C-x>', tabe = '<C-t>', tabnew = '<C-c>n', quit = 'q', close = '<ESC>', }, },
			rename = { in_select = true, auto_save = false, project_max_width = 0.5, project_max_height = 0.5, keys = { quit = '<C-k>', exec = '<CR>', select = 'x', }, },
			symbol_in_winbar = { enable = true, separator = ' › ', hide_keyword = false, ignore_patterns = nil, show_file = true, folder_level = 1, color_mode = true, delay = 300, },
			outline = { win_position = 'right', win_width = 30, auto_preview = true, detail = true, auto_close = true, close_after_jump = false, layout = 'normal', max_height = 0.5, left_width = 0.3, keys = { toggle_or_jump = 'o', quit = 'q', jump = 'e', }, },
			callhierarchy = { layout = 'float', left_width = 0.2, keys = { edit = 'e', vsplit = 's', split = 'i', tabe = 't', close = '<C-c>k', quit = 'q', shuttle = '[w', toggle_or_req = 'u', }, },
			typehierarchy = { layout = 'float', left_width = 0.2, keys = { edit = 'e', vsplit = 's', split = 'i', tabe = 't', close = '<C-c>k', quit = 'q', shuttle = '[w', toggle_or_req = 'u', }, },
			implement = { enable = false, sign = true, lang = {}, virtual_text = true, priority = 100, },
			beacon = { enable = true, frequency = 7, },
			floaterm = { height = 0.7, width = 0.7, },
		})
		vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action" })
		vim.keymap.set({ "n", "v" }, "<leader>co", "<cmd>Lspsaga outline<cr>", { desc = "Code symbol outline" })
		vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>Lspsaga rename<cr>", { desc = "Code rename" })

		vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>Lspsaga finder<cr>", { desc = "Code finder" })
		vim.keymap.set({ "n", "v" }, "<leader>cgi", "<cmd>Lspsaga finder imp<cr>", { desc = "Code implements find" })
		vim.keymap.set({ "n", "v" }, "<leader>cgr", "<cmd>Lspsaga finder ref<cr>", { desc = "Code references find" })
		vim.keymap.set({ "n", "v" }, "<leader>cgd", "<cmd>Lspsaga finder def<cr>", { desc = "Code definition find" })

		vim.keymap.set({ "n", "v" }, "<leader>cs", "<cmd>Lspsaga subtypes<cr>", { desc = "Code subtypes" })
		vim.keymap.set({ "n", "v" }, "<leader>cS", "<cmd>Lspsaga supertypes<cr>", { desc = "Code Supertypes" })
		vim.keymap.set({ "n", "v" }, "<leader>cL", "<cmd>Lspsaga open_log<cr>", { desc = "Code Logs" })
		vim.keymap.set({ "n", "v" }, "<leader>ch", "<cmd>Lspsaga hover_doc<cr>", { desc = "Code hover doc" })

		vim.keymap.set({ "n", "v" }, "<leader>ct", "<cmd>Lspsaga term_toggle<cr>", { desc = "Code toggle term" })
		vim.keymap.set({ "n", "v" }, "<leader>cW", "<cmd>Lspsaga winbar_toggle<cr>", { desc = "Code toggle winbar" })

		vim.keymap.set({ "n", "v" }, "<leader>cI", "<cmd>Lspsaga incomming_calls<cr>", { desc = "Code Incomming calls" })
		vim.keymap.set({ "n", "v" }, "<leader>cO", "<cmd>Lspsaga outgoing_calls<cr>", { desc = "Code Outgoing calls" })

		vim.keymap.set({ "n", "v" }, "<leader>cR", "<cmd>Lspsaga project_replace<cr>", { desc = "Code project Replace" })
		vim.keymap.set({ "n", "v" }, "<leader>cD", "<cmd>Lspsaga goto_definition<cr>", { desc = "Code go to Definition" })
		vim.keymap.set({ "n", "v" }, "<leader>cd", "<cmd>Lspsaga peek_definition<cr>", { desc = "Code peek definition" })

		vim.keymap.set({ "n", "v" }, "<leader>cp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Code previous diagnostic" })
		vim.keymap.set({ "n", "v" }, "<leader>cn", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Code next diagnostic" })
		vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", { desc = "Code cursor diagnostic" })
		vim.keymap.set({ "n", "v" }, "<leader>cl", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Code line diagnostic" })
		vim.keymap.set({ "n", "v" }, "<leader>cb", "<cmd>Lspsaga show_buf_diagnostics<cr>", { desc = "Code buffer diagnostic" })
		vim.keymap.set({ "n", "v" }, "<leader>cw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", { desc = "Code workspace diagnostic" })
	end,
}
