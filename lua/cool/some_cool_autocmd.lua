local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local opt = vim.opt
local o = vim.o
local g = vim.g
local fn = vim.fn

autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
	desc = "Fix scrolloff when you are at the EOF",
	group = augroup("ScrollEOF", { clear = true }),
	callback = function()
		if api.nvim_win_get_config(0).relative ~= "" then
			return -- Ignore floating windows
		end

		local win_height = fn.winheight(0)
		local scrolloff = math.min(o.scrolloff, math.floor(win_height / 2))
		local visual_distance_to_eof = win_height - fn.winline()

		if visual_distance_to_eof < scrolloff then
			local win_view = fn.winsaveview()
			fn.winrestview({ topline = win_view.topline + scrolloff - visual_distance_to_eof })
		end
	end,
})

autocmd("FileType", {
	desc = "Automatically Split help Buffers to the right",
	pattern = "help",
	command = "wincmd L",
})

autocmd("BufWritePre", {
	desc = "Autocreate a dir when saving a file",
	group = augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		fn.mkdir(fn.fnamemodify(file, ":p:h"), "p")
	end,
})

autocmd({ "UIEnter", "ColorScheme" }, {
	desc = "Corrects terminal background color according to colorscheme, see: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/",
	callback = function()
		if api.nvim_get_hl(0, { name = "Normal" }).bg then
			io.write(string.format("\027]11;#%06x\027\\", api.nvim_get_hl(0, { name = "Normal" }).bg))
		end
		autocmd("UILeave", {
			callback = function()
				io.write("\027]111\027\\")
			end,
		})
	end,
})

autocmd("TermOpen", {
	desc = "Remove UI clutter in the terminal",
	callback = function()
		local is_terminal = api.nvim_get_option_value("buftype", { buf = 0 }) == "terminal"
		o.number = not is_terminal
		o.relativenumber = not is_terminal
		o.signcolumn = is_terminal and "no" or "yes"
	end,
})

autocmd("BufReadPost", {
	desc = "Auto jump to last position",
	group = augroup("auto-last-position", { clear = true }),
	callback = function(args)
		local position = api.nvim_buf_get_mark(args.buf, [["]])
		local winid = fn.bufwinid(args.buf)
		pcall(api.nvim_win_set_cursor, winid, position)
	end,
})

autocmd("BufWinEnter", {
	desc = "auto change local current directory",
	group = augroup("auto-project-root", {}),
	callback = function(args)
		if api.nvim_get_option_value("buftype", { buf = args.buf }) ~= "" then
			return
		end

		local root = vim.fs.root(args.buf, function(name, path)
			local pattern = { ".git", "Cargo.toml", "go.mod" }
			local multipattern = { "build/compile_commands.json" }
			local abspath = { fn.stdpath("config") }
			local parentpath = { "~/.config", "~/prj" }

			return vim.iter(pattern):any(function(filepat)
				return filepat == name
			end) or vim.iter(multipattern):any(function(filepats)
				return vim.uv.fs_stat(vim.fs.joinpath(path, vim.fs.normalize(filepats)))
			end) or vim.iter(abspath):any(function(dirpath)
				return vim.fs.normalize(dirpath) == path
			end) or vim.iter(parentpath):any(function(ppath)
				return vim.fs.normalize(ppath) == vim.fs.dirname(path)
			end)
		end)
		if root then
			vim.cmd.lcd(root)
		end
	end,
})
