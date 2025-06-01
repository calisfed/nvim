return {
	enabled = false,
	lazy = false,
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
		{ 'nvim-telescope/telescope-ui-select.nvim' },

		{ 'nvim-tree/nvim-web-devicons',                enabled = vim.g.have_nerd_font },
		{ 'rafi/telescope-thesaurus.nvim',              enabled = true, },
		{ 'nvim-telescope/telescope-file-browser.nvim', enabled = true, },
		{ 'archie-judd/telescope-words.nvim',           enabled = true, },
	},
	config = function()
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`


		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local function copy_all_results(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			local results = {}

			for entry in picker.manager:iter() do
				table.insert(results, entry.value)
			end

			local content = table.concat(results, "\n")
			vim.fn.setreg("+", content) -- Copies to system clipboard
			vim.notify("Copied " .. #results .. " entries to clipboard", vim.log.levels.INFO)
		end

		local function toggle_all(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			for entry in picker.manager:iter() do
				picker._multi:toggle(entry)
			end
		end

		local select_one_or_multi = function(prompt_bufnr)
			local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
			local multi = picker:get_multi_selection()
			if not vim.tbl_isempty(multi) then
				require('telescope.actions').close(prompt_bufnr)
				for _, j in pairs(multi) do
					if j.path ~= nil then
						vim.cmd(string.format('%s %s', 'edit', j.path))
					end
				end
			else
				require('telescope.actions').select_default(prompt_bufnr)
			end
		end

		require('telescope').setup {
			defaults = {
				mappings = { i = {
					['<c-enter>'] = 'to_fuzzy_refine',
					["<esc>"] = actions.close,
					['<C-k>'] = actions.move_selection_previous,
					['<C-j>'] = actions.move_selection_next,
					['<leader>Y'] = copy_all_results,
					['<CR>'] = select_one_or_multi,
				}, },
			},

			pickers = {
				find_files = {
					sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
				},
			},
			extensions = {
				['ui-select'] = {},
				thesaurus = {
					provider = 'freedictionaryapi'
				},
				file_browser = {
					mappings = {

						["i"] = {
							["<C-o>"] = function (prompt_bufnr)
								vim.cmd('edit ' .. prompt_bufnr)
							end
						}
					}
				}
			},
		}

		-- Enable Telescope extensions if they are installed
		pcall(require('telescope').load_extension, 'fzf')
		pcall(require('telescope').load_extension, 'file_browser')
		pcall(require('telescope').load_extension, 'ui-select')


		local function from_git_root()
			local function is_git_repo()
				vim.fn.system("git rev-parse --is-inside-work-tree")
				return vim.v.shell_error == 0
			end

			local function get_git_root()
				local dot_git_path = vim.fn.finddir(".git", ".;")
				return vim.fn.fnamemodify(dot_git_path, ":h")
			end

			local opts = {}
			if is_git_repo() then
				opts = {
					cwd = get_git_root(),
					sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
				}
			end
			return opts
		end


		-- See `:help telescope.builtin`
		-- local ut = require('personal.utils')
		local CallTelescope = function(input, opts)
			opts = opts or {}
			-- opts.layout_config = opts.layout_config or { height = 0.30 }
			-- opts.previewer =  opts.previewer or true
			local theme = opts.theme or require('telescope.themes').get_ivy(opts)

			-- input(theme)
			input(opts)
		end

		vim.keymap.set('n', '<Space>sh', function() CallTelescope(require('telescope.builtin').help_tags, {}) end, { desc = 'Search helps' })
		vim.keymap.set('n', '<Space>sk', function() CallTelescope(require('telescope.builtin').keymaps, {}) end, { desc = 'Search keymaps' })
		vim.keymap.set('n', '<Space>sf', function() CallTelescope(require('telescope.builtin').find_files, from_git_root()) end, { desc = 'Search files' })
		vim.keymap.set('n', '<Space>ss', function() CallTelescope(require('telescope.builtin').git_files, {}) end, { desc = 'Search Git file' })
		vim.keymap.set('n', '<Space>sw', function() CallTelescope(require('telescope.builtin').grep_string, {}) end, { desc = 'Search current word' })
		vim.keymap.set('n', '<Space>sg', function() CallTelescope(require('telescope.builtin').live_grep, {}) end, { desc = 'Search live grep' })
		vim.keymap.set('n', '<Space>sd', function() CallTelescope(require('telescope.builtin').diagnostics, {}) end, { desc = 'Search diagnostics' })
		vim.keymap.set('n', '<Space>sb', function() CallTelescope(require('telescope.builtin').buffers, {}) end, { desc = 'Search buffers' })
		---@diagnostic disable-next-line: undefined-global
		vim.keymap.set('n', '<Space>sm', function() CallTelescope(require('telescope.builtin').man_pages, { sections = ALL }) end, { desc = 'Search manunals' })
		vim.keymap.set('n', '<Space>sr', function() CallTelescope(require('telescope.builtin').registers, {}) end, { desc = 'Search registers' })
		vim.keymap.set('n', '<Space>sl', function() CallTelescope(require('telescope.builtin').loclist, {}) end, { desc = 'Search location list' })
		vim.keymap.set('n', '<Space>sj', function() CallTelescope(require('telescope.builtin').jumplist, {}) end, { desc = 'Search jump list' })
		vim.keymap.set('n', '<Space>st', function() CallTelescope(require('telescope.builtin').treesitter, {}) end, { desc = 'Search treesitter' })
		vim.keymap.set('n', '<Space>s.', function() CallTelescope(require('telescope.builtin').resume, {}) end, { desc = 'Search resume' })
		vim.keymap.set('n', '<Space>sT', function() require('telescope').extensions.thesaurus.lookup() end, { desc = 'Search thesaurus' })
		vim.keymap.set('n', '<Space>sa', ":Telescope ", { desc = 'Telescope ready' })
	end,

}
