return {
	enabled = false,
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	config = function()
		require('snacks').setup({
			animate = {
				duration = 20, -- ms per step
				easing = "linear",
				fps = 60, -- frames per second. Global setting for all animations
			},
			bigfile = {
				enabled = true,
				notify = true,       -- show notification when big file detected
				size = 1.5 * 1024 * 1024, -- 1.5MB
				line_length = 1000,  -- average line length (useful for minified files)
				-- Enable or disable features when big file detected
				---@param ctx {buf: number, ft:string}
				setup = function(ctx)
					if vim.fn.exists(":NoMatchParen") ~= 0 then
						vim.cmd([[NoMatchParen]])
					end
					Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
					vim.b.minianimate_disable = true
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(ctx.buf) then
							vim.bo[ctx.buf].syntax = ctx.ft
						end
					end)
				end,
			},
			dim = {
				scope = { min_size = 5, max_size = 20, siblings = true, },
				animate = {
					enabled = vim.fn.has("nvim-0.10") == 1,
					easing = "outQuad",
					duration = {
						step = 20, -- ms per step
						total = 300, -- maximum duration
					},
					-- what buffers to dim
					filter = function(buf)
						return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
					end,
				},
			},
			explorer = { enabled = true, replace_netrw = true, },
			git = { width = 0.6, height = 0.6, border = "rounded", title = " Git Blame ", title_pos = "center", ft = "git", },
			gitbrowse = {
				{
					notify = true, -- show notification on open
					-- Handler to open the url in a browser
					---@param url string
					open = function(url)
						if vim.fn.has("nvim-0.10") == 0 then
							require("lazy.util").open(url, { system = true })
							return
						end
						vim.ui.open(url)
					end,
					---@type "repo" | "branch" | "file" | "commit" | "permalink"
					what = "commit", -- what to open. not all remotes support all types
					branch = nil, ---@type string?
					line_start = nil, ---@type number?
					line_end = nil, ---@type number?
					-- patterns to transform remotes to an actual URL
					remote_patterns = {
						{ "^(https?://.*)%.git$",               "%1" },
						{ "^git@(.+):(.+)%.git$",               "https://%1/%2" },
						{ "^git@(.+):(.+)$",                    "https://%1/%2" },
						{ "^git@(.+)/(.+)$",                    "https://%1/%2" },
						{ "^org%-%d+@(.+):(.+)%.git$",          "https://%1/%2" },
						{ "^ssh://git@(.*)$",                   "https://%1" },
						{ "^ssh://([^:/]+)(:%d+)/(.*)$",        "https://%1/%3" },
						{ "^ssh://([^/]+)/(.*)$",               "https://%1/%2" },
						{ "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
						{ "^https://%w*@(.*)",                  "https://%1" },
						{ "^git@(.*)",                          "https://%1" },
						{ ":%d+",                               "" },
						{ "%.git$",                             "" },
					},
					url_patterns = {
						["github%.com"] = {
							branch = "/tree/{branch}",
							file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
							permalink = "/blob/{commit}/{file}#L{line_start}-L{line_end}",
							commit = "/commit/{commit}",
						},
						["gitlab%.com"] = {
							branch = "/-/tree/{branch}",
							file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
							permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
							commit = "/-/commit/{commit}",
						},
						["bitbucket%.org"] = {
							branch = "/src/{branch}",
							file = "/src/{branch}/{file}#lines-{line_start}-L{line_end}",
							permalink = "/src/{commit}/{file}#lines-{line_start}-L{line_end}",
							commit = "/commits/{commit}",
						},
						["git.sr.ht"] = {
							branch = "/tree/{branch}",
							file = "/tree/{branch}/item/{file}",
							permalink = "/tree/{commit}/item/{file}#L{line_start}",
							commit = "/commit/{commit}",
						},
					},
					image = {
						formats = { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "mp4", "mov", "avi", "mkv", "webm", "pdf", },
						force = false, -- try displaying the image, even if the terminal does not support it
						doc = {
							-- enable image viewer for documents
							-- a treesitter parser must be available for the enabled languages.
							enabled = true,
							-- render the image inline in the buffer
							-- if your env doesn't support unicode placeholders, this will be disabled
							-- takes precedence over `opts.float` on supported terminals
							inline = true,
							-- render the image in a floating window
							-- only used if `opts.inline` is disabled
							float = true,
							max_width = 80,
							max_height = 40,
							-- Set to `true`, to conceal the image text when rendering inline.
							-- (experimental)
							---@param lang string tree-sitter language
							---@param type snacks.image.Type image type
							conceal = function(lang, type)
								-- only conceal math expressions
								return type == "math"
							end,
						},
						img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
						-- window options applied to windows displaying image buffers
						-- an image buffer is a buffer with `filetype=image`
						wo = { wrap = false, number = false, relativenumber = false, cursorcolumn = false, signcolumn = "no", foldcolumn = "0", list = false, spell = false, statuscolumn = "", },
						cache = vim.fn.stdpath("cache") .. "/snacks/image",
						debug = { request = false, convert = false, placement = false, },
						env = {},
						-- icons used to show where an inline image is located that is
						-- rendered below the text.
						icons = { math = "󰪚 ", chart = "󰄧 ", image = " ", },
						---@class snacks.image.convert.Config
						convert = {
							notify = true, -- show a notification on error
							---@type snacks.image.args
							mermaid = function()
								local theme = vim.o.background == "light" and "neutral" or "dark"
								return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
							end,
							---@type table<string,snacks.image.args>
							magick = {
								default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
								vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
								math = { "-density", 192, "{src}[0]", "-trim" },
								pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
							},
						},
						math = {
							enabled = true, -- enable math expression rendering
							-- in the templates below, `${header}` comes from any section in your document,
							-- between a start/end header comment. Comment syntax is language-specific.
							-- * start comment: `// snacks: header start`
							-- * end comment:   `// snacks: header end`
							typst = {
								tpl = [[
				#set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
				#show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
				#set text(size: 12pt, fill: rgb("${color}"))
				${header}
				${content}]],
							},
							latex = {
								font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
								-- for latex documents, the doc packages are included automatically,
								-- but you can add more packages here. Useful for markdown documents.
								packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
								tpl = [[
				\documentclass[preview,border=0pt,varwidth,12pt]{standalone}
				\usepackage{${packages}}
				\begin{document}
				${header}
				{ \${font_size} \selectfont
					\color[HTML]{${color}}
				${content}}
				\end{document}]],
							},
						},
					},
					indent = {
						enabled = true,
						indent = {
							priority = 1,
							enabled = true, -- enable indent guides
							char = "│",
							only_scope = false, -- only show indent guides of the scope
							only_current = false, -- only show indent guides in the current window
							hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
							-- can be a list of hl groups to cycle through
							-- hl = {
							--     "SnacksIndent1",
							--     "SnacksIndent2",
							--     "SnacksIndent3",
							--     "SnacksIndent4",
							--     "SnacksIndent5",
							--     "SnacksIndent6",
							--     "SnacksIndent7",
							--     "SnacksIndent8",
							-- },
						},
						-- animate scopes. Enabled by default for Neovim >= 0.10
						-- Works on older versions but has to trigger redraws during animation.
						---@class snacks.indent.animate: snacks.animate.Config
						---@field enabled? boolean
						--- * out: animate outwards from the cursor
						--- * up: animate upwards from the cursor
						--- * down: animate downwards from the cursor
						--- * up_down: animate up or down based on the cursor position
						---@field style? "out"|"up_down"|"down"|"up"
						animate = {
							enabled = vim.fn.has("nvim-0.10") == 1,
							style = "out",
							easing = "linear",
							duration = {
								step = 20, -- ms per step
								total = 500, -- maximum duration
							},
						},
						---@class snacks.indent.Scope.Config: snacks.scope.Config
						scope = {
							enabled = true, -- enable highlighting the current scope
							priority = 200,
							char = "│",
							underline = false, -- underline the start of the scope
							only_current = false, -- only show scope in the current window
							hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
						},
						chunk = {
							-- when enabled, scopes will be rendered as chunks, except for the
							-- top-level scope which will be rendered as a scope.
							enabled = false,
							-- only show chunk scopes in the current window
							only_current = false,
							priority = 200,
							hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
							char = {
								corner_top = "┌",
								corner_bottom = "└",
								-- corner_top = "╭",
								-- corner_bottom = "╰",
								horizontal = "─",
								vertical = "│",
								arrow = ">",
							},
						},
						-- filter for buffers to enable indent guides
						filter = function(buf)
							return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
						end,
					},
					input = { enabled = true, icon = " ", icon_hl = "SnacksInputIcon", icon_pos = "left", prompt_pos = "title", win = { style = "input" }, expand = true, },
					lazygit = {
						-- automatically configure lazygit to use the current colorscheme
						-- and integrate edit with the current neovim instance
						configure = true,
						-- extra configuration for lazygit that will be merged with the default
						-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
						-- you need to double quote it: `"\"test\""`
						config = {
							os = { editPreset = "nvim-remote" },
							gui = {
								-- set to an empty string "" to disable icons
								nerdFontsVersion = "3",
							},
						},
						theme_path = svim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
						-- Theme for lazygit
						theme = {
							[241]                      = { fg = "Special" },
							activeBorderColor          = { fg = "MatchParen", bold = true },
							cherryPickedCommitBgColor  = { fg = "Identifier" },
							cherryPickedCommitFgColor  = { fg = "Function" },
							defaultFgColor             = { fg = "Normal" },
							inactiveBorderColor        = { fg = "FloatBorder" },
							optionsTextColor           = { fg = "Function" },
							searchingActiveBorderColor = { fg = "MatchParen", bold = true },
							selectedLineBgColor        = { bg = "Visual" }, -- set to `default` to have no background colour
							unstagedChangesColor       = { fg = "DiagnosticError" },
						},
						win = {
							style = "lazygit",
						},
					},
					picker = {
						enabled = true,
						prompt = " ",
						sources = {},
						focus = "input",
						layout = {
							cycle = true,
							--- Use the default layout or vertical if the window is too narrow
							preset = function()
								return vim.o.columns >= 120 and "default" or "vertical"
							end,
						},
						---@class snacks.picker.matcher.Config
						matcher = {
							fuzzy = true,  -- use fuzzy matching
							smartcase = true, -- use smartcase
							ignorecase = true, -- use ignorecase
							sort_empty = false, -- sort results when the search string is empty
							filename_bonus = true, -- give bonus for matching file names (last part of the path)
							file_pos = true, -- support patterns like `file:line:col` and `file:line`
							-- the bonusses below, possibly require string concatenation and path normalization,
							-- so this can have a performance impact for large lists and increase memory usage
							cwd_bonus = false, -- give bonus for matching files in the cwd
							frecency = false, -- frecency bonus
							history_bonus = false, -- give more weight to chronological order
						},
						sort = {
							-- default sort is by score, text length and index
							fields = { "score:desc", "#text", "idx" },
						},
						ui_select = true, -- replace `vim.ui.select` with the snacks picker
						---@class snacks.picker.formatters.Config
						formatters = {
							text = {
								ft = nil, ---@type string? filetype for highlighting
							},
							file = {
								filename_first = false, -- display filename before the file path
								truncate = 40, -- truncate the file path to (roughly) this length
								filename_only = false, -- only show the filename
								icon_width = 2, -- width of the icon (in characters)
								git_status_hl = true, -- use the git status highlight group for the filename
							},
							selected = {
								show_always = false, -- only show the selected column when there are multiple selections
								unselected = true, -- use the unselected icon for unselected items
							},
							severity = {
								icons = true, -- show severity icons
								level = false, -- show severity level
								---@type "left"|"right"
								pos = "left", -- position of the diagnostics
							},
						},
						---@class snacks.picker.previewers.Config
						previewers = {
							diff = {
								builtin = true, -- use Neovim for previewing diffs (true) or use an external tool (false)
								cmd = { "delta" }, -- example to show a diff with delta
							},
							git = {
								builtin = true, -- use Neovim for previewing git output (true) or use git (false)
								args = {}, -- additional arguments passed to the git command. Useful to set pager options usin `-c ...`
							},
							file = {
								max_size = 1024 * 1024, -- 1MB
								max_line_length = 500, -- max line length
								ft = nil, ---@type string? filetype for highlighting. Use `nil` for auto detect
							},
							man_pager = nil, ---@type string? MANPAGER env to use for `man` preview
						},
						---@class snacks.picker.jump.Config
						jump = {
							jumplist = true, -- save the current position in the jumplist
							tagstack = false, -- save the current position in the tagstack
							reuse_win = false, -- reuse an existing window if the buffer is already open
							close = true, -- close the picker when jumping/editing to a location (defaults to true)
							match = false, -- jump to the first match position. (useful for `lines`)
						},
						toggles = {
							follow = "f",
							hidden = "h",
							ignored = "i",
							modified = "m",
							regex = { icon = "R", value = false },
						},
						win = {
							-- input window
							input = {
								keys = {
									-- to close the picker on ESC instead of going to normal mode,
									-- add the following keymap to your config
									-- ["<Esc>"] = { "close", mode = { "n", "i" } },
									["/"] = "toggle_focus",
									["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
									["<C-Up>"] = { "history_back", mode = { "i", "n" } },
									["<C-c>"] = { "cancel", mode = "i" },
									["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
									["<CR>"] = { "confirm", mode = { "n", "i" } },
									["<Down>"] = { "list_down", mode = { "i", "n" } },
									["<Esc>"] = "cancel",
									["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
									["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
									["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
									["<Up>"] = { "list_up", mode = { "i", "n" } },
									["<a-d>"] = { "inspect", mode = { "n", "i" } },
									["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
									["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
									["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
									["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
									["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
									["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
									["<c-a>"] = { "select_all", mode = { "n", "i" } },
									["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
									["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
									["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
									["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
									["<c-j>"] = { "list_down", mode = { "i", "n" } },
									["<c-k>"] = { "list_up", mode = { "i", "n" } },
									["<c-n>"] = { "list_down", mode = { "i", "n" } },
									["<c-p>"] = { "list_up", mode = { "i", "n" } },
									["<c-q>"] = { "qflist", mode = { "i", "n" } },
									["<c-s>"] = { "edit_split", mode = { "i", "n" } },
									["<c-t>"] = { "tab", mode = { "n", "i" } },
									["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
									["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
									["<c-r>#"] = { "insert_alt", mode = "i" },
									["<c-r>%"] = { "insert_filename", mode = "i" },
									["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
									["<c-r><c-f>"] = { "insert_file", mode = "i" },
									["<c-r><c-l>"] = { "insert_line", mode = "i" },
									["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
									["<c-r><c-w>"] = { "insert_cword", mode = "i" },
									["<c-w>H"] = "layout_left",
									["<c-w>J"] = "layout_bottom",
									["<c-w>K"] = "layout_top",
									["<c-w>L"] = "layout_right",
									["?"] = "toggle_help_input",
									["G"] = "list_bottom",
									["gg"] = "list_top",
									["j"] = "list_down",
									["k"] = "list_up",
									["q"] = "close",
								},
								b = {
									minipairs_disable = true,
								},
							},
							-- result list window
							list = {
								keys = {
									["/"] = "toggle_focus",
									["<2-LeftMouse>"] = "confirm",
									["<CR>"] = "confirm",
									["<Down>"] = "list_down",
									["<Esc>"] = "cancel",
									["<S-CR>"] = { { "pick_win", "jump" } },
									["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
									["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
									["<Up>"] = "list_up",
									["<a-d>"] = "inspect",
									["<a-f>"] = "toggle_follow",
									["<a-h>"] = "toggle_hidden",
									["<a-i>"] = "toggle_ignored",
									["<a-m>"] = "toggle_maximize",
									["<a-p>"] = "toggle_preview",
									["<a-w>"] = "cycle_win",
									["<c-a>"] = "select_all",
									["<c-b>"] = "preview_scroll_up",
									["<c-d>"] = "list_scroll_down",
									["<c-f>"] = "preview_scroll_down",
									["<c-j>"] = "list_down",
									["<c-k>"] = "list_up",
									["<c-n>"] = "list_down",
									["<c-p>"] = "list_up",
									["<c-q>"] = "qflist",
									["<c-s>"] = "edit_split",
									["<c-t>"] = "tab",
									["<c-u>"] = "list_scroll_up",
									["<c-v>"] = "edit_vsplit",
									["<c-w>H"] = "layout_left",
									["<c-w>J"] = "layout_bottom",
									["<c-w>K"] = "layout_top",
									["<c-w>L"] = "layout_right",
									["?"] = "toggle_help_list",
									["G"] = "list_bottom",
									["gg"] = "list_top",
									["i"] = "focus_input",
									["j"] = "list_down",
									["k"] = "list_up",
									["q"] = "close",
									["zb"] = "list_scroll_bottom",
									["zt"] = "list_scroll_top",
									["zz"] = "list_scroll_center",
								},
								wo = {
									conceallevel = 2,
									concealcursor = "nvc",
								},
							},
							-- preview window
							preview = {
								keys = {
									["<Esc>"] = "cancel",
									["q"] = "close",
									["i"] = "focus_input",
									["<a-w>"] = "cycle_win",
								},
							},
						},
						---@class snacks.picker.icons
						icons = {
							files = {
								enabled = true, -- show file icons
								dir = "󰉋 ",
								dir_open = "󰝰 ",
								file = "󰈔 "
							},
							keymaps = {
								nowait = "󰓅 "
							},
							tree = {
								vertical = "│ ",
								middle   = "├╴",
								last     = "└╴",
							},
							undo = {
								saved = " ",
							},
							ui = {
								live       = "󰐰 ",
								hidden     = "h",
								ignored    = "i",
								follow     = "f",
								selected   = "● ",
								unselected = "○ ",
								-- selected = " ",
							},
							git = {
								enabled   = true, -- show git icons
								commit    = "󰜘 ", -- used by git log
								staged    = "●", -- staged changes. always overrides the type icons
								added     = "",
								deleted   = "",
								ignored   = " ",
								modified  = "○",
								renamed   = "",
								unmerged  = " ",
								untracked = "?",
							},
							diagnostics = {
								Error = " ",
								Warn  = " ",
								Hint  = " ",
								Info  = " ",
							},
							lsp = {
								unavailable = "",
								enabled = " ",
								disabled = " ",
								attached = "󰖩 "
							},
							kinds = {
								Array         = " ",
								Boolean       = "󰨙 ",
								Class         = " ",
								Color         = " ",
								Control       = " ",
								Collapsed     = " ",
								Constant      = "󰏿 ",
								Constructor   = " ",
								Copilot       = " ",
								Enum          = " ",
								EnumMember    = " ",
								Event         = " ",
								Field         = " ",
								File          = " ",
								Folder        = " ",
								Function      = "󰊕 ",
								Interface     = " ",
								Key           = " ",
								Keyword       = " ",
								Method        = "󰊕 ",
								Module        = " ",
								Namespace     = "󰦮 ",
								Null          = " ",
								Number        = "󰎠 ",
								Object        = " ",
								Operator      = " ",
								Package       = " ",
								Property      = " ",
								Reference     = " ",
								Snippet       = "󱄽 ",
								String        = " ",
								Struct        = "󰆼 ",
								Text          = " ",
								TypeParameter = " ",
								Unit          = " ",
								Unknown       = " ",
								Value         = " ",
								Variable      = "󰀫 ",
							},
						},
						---@class snacks.picker.db.Config
						db = {
							-- path to the sqlite3 library
							-- If not set, it will try to load the library by name.
							-- On Windows it will download the library from the internet.
							sqlite3_path = nil, ---@type string?
						},
						---@class snacks.picker.debug
						debug = {
							scores = false, -- show scores in the list
							leaks = false, -- show when pickers don't get garbage collected
							explorer = false, -- show explorer debug info
							files = false, -- show file debug info
							grep = false, -- show file debug info
							proc = false, -- show proc debug info
							extmarks = false, -- show extmarks errors
						},
					},
					notifier = {
						enabled = true,
						timeout = 3000, -- default timeout in ms
						width = { min = 40, max = 0.4 },
						height = { min = 1, max = 0.6 },
						-- editor margin to keep free. tabline and statusline are taken into account automatically
						margin = { top = 0, right = 1, bottom = 0 },
						padding = true,       -- add 1 cell of left/right padding to the notification window
						sort = { "level", "added" }, -- sort by level and time
						-- minimum log level to display. TRACE is the lowest
						-- all notifications are stored in history
						level = vim.log.levels.TRACE,
						icons = {
							error = " ",
							warn = " ",
							info = " ",
							debug = " ",
							trace = " ",
						},
						keep = function(notif)
							return vim.fn.getcmdpos() > 0
						end,
						---@type snacks.notifier.style
						style = "compact",
						top_down = true, -- place notifications from top to bottom
						date_format = "%R", -- time format for notifications
						-- format for footer when more lines are available
						-- `%d` is replaced with the number of lines.
						-- only works for styles with a border
						---@type string|boolean
						more_format = " ↓ %d lines ",
						refresh = 50, -- refresh at most every 50ms
					},
					profiler = {
						autocmds = true,
						runtime = vim.env.VIMRUNTIME, ---@type string
						-- thresholds for buttons to be shown as info, warn or error
						-- value is a tuple of [warn, error]
						thresholds = {
							time = { 2, 10 },
							pct = { 10, 20 },
							count = { 10, 100 },
						},
						on_stop = {
							highlights = true, -- highlight entries after stopping the profiler
							pick = true, -- show a picker after stopping the profiler (uses the `on_stop` preset)
						},
						---@type snacks.profiler.Highlights
						highlights = {
							min_time = 0, -- only highlight entries with time > min_time (in ms)
							max_shade = 20, -- time in ms for the darkest shade
							badges = { "time", "pct", "count", "trace" },
							align = 80,
						},
						pick = {
							picker = "snacks", ---@type snacks.profiler.Picker
							---@type snacks.profiler.Badge.type[]
							badges = { "time", "count", "name" },
							---@type snacks.profiler.Highlights
							preview = {
								badges = { "time", "pct", "count" },
								align = "right",
							},
						},
						startup = {
							event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
							after = true, -- stop the profiler **after** the event. When false it stops **at** the event
							pattern = nil, -- pattern to match for the autocmd
							pick = true, -- show a picker after starting the profiler (uses the `startup` preset)
						},
						---@type table<string, snacks.profiler.Pick|fun():snacks.profiler.Pick?>
						presets = {
							startup = { min_time = 1, sort = false },
							on_stop = {},
							filter_by_plugin = function()
								return { filter = { def_plugin = vim.fn.input("Filter by plugin: ") } }
							end,
						},
						---@type string[]
						globals = {
							-- "vim",
							-- "vim.api",
							-- "vim.keymap",
							-- "Snacks.dashboard.Dashboard",
						},
						-- filter modules by pattern.
						-- longest patterns are matched first
						filter_mod = {
							default = true, -- default value for unmatched patterns
							["^vim%."] = false,
							["mason-core.functional"] = false,
							["mason-core.functional.data"] = false,
							["mason-core.optional"] = false,
							["which-key.state"] = false,
						},
						filter_fn = {
							default = true,
							["^.*%._[^%.]*$"] = false,
							["trouble.filter.is"] = false,
							["trouble.item.__index"] = false,
							["which-key.node.__index"] = false,
							["smear_cursor.draw.wo"] = false,
							["^ibl%.utils%."] = false,
						},
						icons = {
							time    = " ",
							pct     = " ",
							count   = " ",
							require = "󰋺 ",
							modname = "󰆼 ",
							plugin  = " ",
							autocmd = "⚡",
							file    = " ",
							fn      = "󰊕 ",
							status  = "󰈸 ",
						},
					},
					quickfile = { enabled = true, exclude = { "latex" }, },
					scope = {
						enabled = true,
						-- absolute minimum size of the scope.
						-- can be less if the scope is a top-level single line scope
						min_size = 2,
						-- try to expand the scope to this size
						max_size = nil,
						cursor = true, -- when true, the column of the cursor is used to determine the scope
						edge = true, -- include the edge of the scope (typically the line above and below with smaller indent)
						siblings = false, -- expand single line scopes with single line siblings
						-- what buffers to attach to
						filter = function(buf)
							return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false
						end,
						-- debounce scope detection in ms
						debounce = 30,
						treesitter = {
							-- detect scope based on treesitter.
							-- falls back to indent based detection if not available
							enabled = true,
							injections = true, -- include language injections when detecting scope (useful for languages like `vue`)
							---@type string[]|{enabled?:boolean}
							blocks = {
								enabled = false, -- enable to use the following blocks
								"function_declaration",
								"function_definition",
								"method_declaration",
								"method_definition",
								"class_declaration",
								"class_definition",
								"do_statement",
								"while_statement",
								"repeat_statement",
								"if_statement",
								"for_statement",
							},
							-- these treesitter fields will be considered as blocks
							field_blocks = {
								"local_declaration",
							},
						},
						-- These keymaps will only be set if the `scope` plugin is enabled.
						-- Alternatively, you can set them manually in your config,
						-- using the `Snacks.scope.textobject` and `Snacks.scope.jump` functions.
						keys = {
							---@type table<string, snacks.scope.TextObject|{desc?:string}>
							textobject = {
								ii = {
									min_size = 2, -- minimum size of the scope
									edge = false, -- inner scope
									cursor = false,
									treesitter = { blocks = { enabled = false } },
									desc = "inner scope",
								},
								ai = {
									cursor = false,
									min_size = 2, -- minimum size of the scope
									treesitter = { blocks = { enabled = false } },
									desc = "full scope",
								},
							},
							---@type table<string, snacks.scope.Jump|{desc?:string}>
							jump = {
								["[i"] = {
									min_size = 1, -- allow single line scopes
									bottom = false,
									cursor = false,
									edge = true,
									treesitter = { blocks = { enabled = false } },
									desc = "jump to top edge of scope",
								},
								["]i"] = {
									min_size = 1, -- allow single line scopes
									bottom = true,
									cursor = false,
									edge = true,
									treesitter = { blocks = { enabled = false } },
									desc = "jump to bottom edge of scope",
								},
							},
						},
					},
					scroll = {
						enabled = true,
						name = "Scratch",
						ft = function()
							if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
								return vim.bo.filetype
							end
							return "markdown"
						end,
						---@type string|string[]?
						icon = nil, -- `icon|{icon, icon_hl}`. defaults to the filetype icon
						root = vim.fn.stdpath("data") .. "/scratch",
						autowrite = true, -- automatically write when the buffer is hidden
						-- unique key for the scratch file is based on:
						-- * name
						-- * ft
						-- * vim.v.count1 (useful for keymaps)
						-- * cwd (optional)
						-- * branch (optional)
						filekey = {
							cwd = true, -- use current working directory
							branch = true, -- use current branch name
							count = true, -- use vim.v.count1
						},
						win = { style = "scratch" },
						---@type table<string, snacks.win.Config>
						win_by_ft = {
							lua = {
								keys = {
									["source"] = {
										"<cr>",
										function(self)
											local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
											Snacks.debug.run({ buf = self.buf, name = name })
										end,
										desc = "Source buffer",
										mode = { "n", "x" },
									},
								},
							},
						},
					},
					scroll = {
						animate = {
							duration = { step = 15, total = 250 },
							easing = "linear",
						},
						-- faster animation when repeating scroll after delay
						animate_repeat = {
							delay = 100, -- delay in ms before using the repeat animation
							duration = { step = 5, total = 50 },
							easing = "linear",
						},
						-- what buffers to animate
						filter = function(buf)
							return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
						end,
					},
					statuscolumn = {
						enabled = true,
						left = { "mark", "sign" }, -- priority of signs on the left (high to low)
						right = { "fold", "git" }, -- priority of signs on the right (high to low)
						folds = {
							open = false,     -- show open fold icons
							git_hl = false,   -- use Git Signs hl for fold icons
						},
						git = {
							-- patterns to match Git signs
							patterns = { "GitSign", "MiniDiffSign" },
						},
						refresh = 50, -- refresh at most every 50ms
					},
					toggle = {
						map = vim.keymap.set, -- keymap.set function to use
						which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
						notify = true, -- show a notification when toggling
						-- icons for enabled/disabled states
						icon = {
							enabled = " ",
							disabled = " ",
						},
						-- colors for enabled/disabled states
						color = {
							enabled = "green",
							disabled = "yellow",
						},
						wk_desc = {
							enabled = "Disable ",
							disabled = "Enable ",
						},
					},
					words = { enabled = true },
					zen = {
						-- You can add any `Snacks.toggle` id here.
						-- Toggle state is restored when the window is closed.
						-- Toggle config options are NOT merged.
						---@type table<string, boolean>
						toggles = {
							dim = true,
							git_signs = false,
							mini_diff_signs = false,
							-- diagnostics = false,
							-- inlay_hints = false,
						},
						show = {
							statusline = false, -- can only be shown when using the global statusline
							tabline = false,
						},
						---@type snacks.win.Config
						win = { style = "zen" },
						--- Callback when the window is opened.
						---@param win snacks.win
						on_open = function(win) end,
						--- Callback when the window is closed.
						---@param win snacks.win
						on_close = function(win) end,
						--- Options for the `Snacks.zen.zoom()`
						---@type snacks.zen.Config
						zoom = {
							toggles = {},
							show = { statusline = true, tabline = true },
							win = {
								backdrop = false,
								width = 0, -- full width
							},
						},
					},
					dashboard =
					{
						enabled = true,
						width = 60,
						row = nil,                                                             -- dashboard position. nil for center
						col = nil,                                                             -- dashboard position. nil for center
						pane_gap = 4,                                                          -- empty columns between vertical panes
						autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
						-- These settings are used by some built-in sections
						preset = {
							-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
							---@type fun(cmd:string, opts:table)|nil
							pick = nil,
							-- Used by the `keys` section to show keymaps.
							-- Set your custom keymaps here.
							-- When using a function, the `items` argument are the default keymaps.
							---@type snacks.dashboard.Item[]
							keys = {
								{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
								{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
								{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
								{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
								{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
								{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
								{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
								{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
							},
							-- Used by the `header` section
							header = [[
		███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
		████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
		██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
		██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
		██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
		╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
						},
						-- item field formatters
						formats = {
							icon = function(item)
								if item.file and item.icon == "file" or item.icon == "directory" then
									return M.icon(item.file, item.icon)
								end
								return { item.icon, width = 2, hl = "icon" }
							end,
							footer = { "%s", align = "center" },
							header = { "%s", align = "center" },
							file = function(item, ctx)
								local fname = vim.fn.fnamemodify(item.file, ":~")
								fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
								if #fname > ctx.width then
									local dir = vim.fn.fnamemodify(fname, ":h")
									local file = vim.fn.fnamemodify(fname, ":t")
									if dir and file then
										file = file:sub(-(ctx.width - #dir - 2))
										fname = dir .. "/…" .. file
									end
								end
								local dir, file = fname:match("^(.*)/(.+)$")
								return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
							end,
						},
						sections = {
							{ section = "header" },
							{ section = "keys",   gap = 1, padding = 1 },
							{ section = "startup" },
						},
					}
				} }
		})
		_G.dd = function(...)
			Snacks.debug.inspect(...)
		end
		_G.bt = function()
			Snacks.debug.backtrace()
		end
		vim.print = _G.dd
	end
}
