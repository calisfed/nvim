return {
	enabled = false,
	dependencies = {
		{ 'mason-org/mason.nvim',           opts = { ensure_installed = { "tree-sitter-cli", "lua_ls" } }, },
		{ 'mason-org/mason-lspconfig.nvim', dependencies = { 'neovim/nvim-lspconfig', 'mason-org/mason.nvim' } },
		-- 'WhoIsSethDaniel/mason-tool-installer.nvim',
		{ 'j-hui/fidget.nvim',              opts = { notification = { window = { winblend = 0, } } } },
	},
	lazy = false,
	'neovim/nvim-lspconfig',
	config = function()
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						format = {
							-- column_witdh = vim.fn.winwidth(0),
							defaultConfig = {
								max_line_length = "200",
							},
							-- editorConfig = {
							--   max_line_length = 200,
							-- }
						},
						runtime = { version = 'LuaJIT' },
						workspace = {
							checkThirdParty = false,
							-- Tells lua_ls where to find all the Lua files that you have loaded
							-- for your neovim configuration.
							library = {
								'${3rd}/luv/library',
								unpack(vim.api.nvim_get_runtime_file('', true)),
								vim.env.VIMRUNTIME,
								"/usr/share/awesome/lib",
							},
							-- If lua_ls is really slow on your computer, you can try this instead:
							-- library = { vim.env.VIMRUNTIME },
						},
						completion = {
							callSnippet = 'Replace',
						},
						diagnostics = {
							disable = { 'missing-fields' },
							globals = { "vim", "awesome", "client", "root", "screen", "mouse"
							},
						},
					},
				},
			},
			zls = {
				-- --   -- cmd = { 'zls' },
				-- format = {
				--   defaultConfig = {
				--     max_line_length = "200",
				--   },
				-- },
				settings = {
					enable_autofix  = true,
					enable_snippets = true,
					-- prefer_ast_check_as_child_process = false,
				},
			},
			bashls = {
				filetypes = { 'zsh', 'sh' },
				pattern = { 'sh' },
			},
			typos_lsp = {
				filetypes = { 'typst' },
			},

			tinymist = {
				-- https://github.com/Myriad-Dreamin/tinymist/blob/main/editors/vscode/Configuration.md
				settings = {
					-- exportTarget = "html",
					exportPdf = "onType",
					outputPath = "$root/target/$dir/$name",
				}
			},

			harper_ls = {
				filetypes = { "markdown", "text", "doc" },
				settings = {
					["harper-ls"] = {
						userDictPath = "",
						fileDictPath = "",
						linters = {
							SpellCheck = false,
							SpelledNumbers = false,
							AnA = true,
							SentenceCapitalization = true,
							UnclosedQuotes = true,
							WrongQuotes = false,
							LongSentences = true,
							RepeatedWords = true,
							Spaces = false,
							Matcher = true,
							CorrectNumberSuffix = true
						},
						codeActions = {
							ForceStable = false
						},
						markdown = {
							IgnoreLinkTitle = false
						},
						diagnosticSeverity = "hint",
						isolateEnglish = false,
						-- dialect: "American",
					}
				}
			},
			clangd = {
				cmd = {
					"clangd",
					-- "--compile-commands-dir=build",
					-- "--clang-tidy",
					-- "--completion-style=detailed",
					-- "--std=c99"
					-- "--header-insertion=never"
				},
				filetypes = { "c" },
			},
			-- htmx = {},
			-- },
			asm_lsp = {},
			-- ltex_plus = {},
			html = {
				filetypes = { "markdown", "html", "javascript", "typescript" },
			}
		}
		--
		require('mason').setup()
		require('mason-lspconfig').setup({
			ensure_installed = {
				-- 'tree-sitter-cli',
				'lua_ls',
			}
		})
		for server_name, server_config in pairs(servers) do
			vim.lsp.config(server_name, server_config)
		end
	end
}
