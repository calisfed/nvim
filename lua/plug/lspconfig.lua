-- return

--   {   -- LSP Configuration & Plugins
--     enabled = false,
--
--     -- event = "VeryLazy",
--
--     dependencies = {
--       -- Automatically install LSPs and related tools to stdpath for neovim
--       'williamboman/mason.nvim',
--       'williamboman/mason-lspconfig.nvim',
--       'WhoIsSethDaniel/mason-tool-installer.nvim',
--       {
--         'j-hui/fidget.nvim',
--         opts = { notification = { window = { winblend = 0, } }
--         }
--       },
--     },
--     lazy = false,
--     'neovim/nvim-lspconfig',
--     config = function()
--       vim.api.nvim_create_autocmd('LspAttach', {
--         group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
--         callback = function(event)
--           local client = vim.lsp.get_client_by_id(event.data.client_id)
--           if client and client.server_capabilities.documentHighlightProvider then
--             vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--               buffer = event.buf,
--               callback = vim.lsp.buf.document_highlight,
--             })
--
--             vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
--               buffer = event.buf,
--               callback = vim.lsp.buf.clear_references,
--             })
--           end
--           -- vim.lsp.completion.enable(true, event.data.client_id, event.buf, { autotrigger = true })
--         end,
--       })
--
--       local capabilities = vim.lsp.protocol.make_client_capabilities()
--       if pcall(require, "cmp_nvim_lsp") then capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities()) end
--       if pcall(require, "blink.cmp") then capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({})) end
--
--       --  Add any additional override configuration in the following tables. Available keys are:
--       --  - cmd (table): Override the default command used to start the server
--       --  - filetypes (table): Override the default list of associated filetypes for the server
--       --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--       --  - settings (table): Override the default settings passed when initializing the server.
--       --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
--       local servers = {
--         lua_ls = {
--           settings = {
--             Lua = {
--               format = {
--                 -- column_witdh = vim.fn.winwidth(0),
--                 defaultConfig = {
--                   max_line_length = "200",
--                 },
--                 -- editorConfig = {
--                 --   max_line_length = 200,
--                 -- }
--               },
--               runtime = { version = 'LuaJIT' },
--               workspace = {
--                 checkThirdParty = false,
--                 -- Tells lua_ls where to find all the Lua files that you have loaded
--                 -- for your neovim configuration.
--                 library = {
--                   '${3rd}/luv/library',
--                   unpack(vim.api.nvim_get_runtime_file('', true)),
--                   "/usr/share/awesome/lib",
--                 },
--                 -- If lua_ls is really slow on your computer, you can try this instead:
--                 -- library = { vim.env.VIMRUNTIME },
--               },
--               completion = {
--                 callSnippet = 'Replace',
--               },
--               diagnostics = {
--                 disable = { 'missing-fields' },
--                 globals = {
--                   "vim",
--                   "awesome", "client", "root", "screen", "mouse"
--                 },
--               },
--             },
--           },
--         },
--         zls = {
--           -- --   -- cmd = { 'zls' },
--           -- format = {
--           --   defaultConfig = {
--           --     max_line_length = "200",
--           --   },
--           -- },
--           settings = {
--             enable_autofix  = true,
--             enable_snippets = true,
--             -- prefer_ast_check_as_child_process = false,
--           },
--         },
--         bashls = {
--           filetypes = { 'zsh', 'sh' },
--           pattern = { 'sh' },
--         },
--         typos_lsp = {
--           -- filetypes = { 'typst' },
--         },
--
--         tinymist = {
--           settings = {
--             exportPdf = "onType",
--             outputPath = "$root/target/$dir/$name",
--           }
--         },
--
--         harper_ls = {
--           filetypes = { "markdown", "text", "doc" },
--           settings = {
--             ["harper-ls"] = {
--               userDictPath = "",
--               fileDictPath = "",
--               linters = {
--                 SpellCheck = false,
--                 SpelledNumbers = false,
--                 AnA = true,
--                 SentenceCapitalization = true,
--                 UnclosedQuotes = true,
--                 WrongQuotes = false,
--                 LongSentences = true,
--                 RepeatedWords = true,
--                 Spaces = true,
--                 Matcher = true,
--                 CorrectNumberSuffix = true
--               },
--               codeActions = {
--                 ForceStable = false
--               },
--               markdown = {
--                 IgnoreLinkTitle = false
--               },
--               diagnosticSeverity = "hint",
--               isolateEnglish = false,
--               -- dialect: "American",
--             }} },
--         clangd = {
--           cmd = {
--             "clangd",
--             -- "--compile-commands-dir=build",
--             -- "--clang-tidy",
--             -- "--completion-style=detailed",
--             -- "--std=c99"
--             -- "--header-insertion=never"
--           },
--           filetypes = { "c" },
--         },
--         -- htmx = {},
--         -- },
--         asm_lsp = {},
--       }
--
--       require('mason').setup()
--
--       local ensure_installed = vim.tbl_keys(servers or {})
--       vim.list_extend(ensure_installed, {
--         'lua_ls',
--         -- 'stylua', -- Used to format lua code
--         -- 'zls@0.12.0',
--       })
--       require('mason-tool-installer').setup { ensure_installed = ensure_installed }
--
--       require('mason-lspconfig').setup {
--         handlers = {
--           function(server_name)
--             local server = servers[server_name] or {}
--             server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
--             -- server.capabilities = require('blink.cmp').get_lsp_capabilities(server.capabilities)
--             server.handlers = {
--               ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
--               ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
--             } or {}
--
--             -- require('lspconfig')[server_name].setup(server)
-- 						vim.lsp.config(server_name, server)
--
--
--             -- require('lspconfig').ccls.setup {
--             --   default_config = {
--             --     cmd = { 'ccls' },
--             --     filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
--             --     root_dir = function(fname)
--             --       return require('lspconfig.util').root_pattern('compile_commands.json', '.ccls')(fname) or require('lspconfig.util').find_git_ancestor(fname)
--             --     end,
--             --     -- offset_encoding = 'utf-32',
--             --     -- ccls does not support sending a null root directory
--             --     single_file_support = true,
--             --   },
--             --   init_options = {
--             --     compilationDatabaseDirectory = "build";
--             --     index = {
--             --       threads = 0;
--             --     };
--             --     clang = {
--             --       excludeArgs = { "-frounding-math"} ;
--             --     };
--             --   }
--             -- }
--           end,
--         },
--       }
--     end
--   }
--


return
	{   -- LSP Configuration & Plugins
		enabled = false,

		-- event = "VeryLazy",

		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for neovim
			{ 'williamboman/mason.nvim',
				opts = { ensure_installed = { "tree-sitter-cli", "lua_ls" } },
			},

			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			{
				'j-hui/fidget.nvim',
				opts = { notification = { window = { winblend = 0, } }
				}
			},
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
								globals = {
									"vim",
									"awesome", "client", "root", "screen", "mouse"
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
					settings = {
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
								Spaces = true,
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
						}} },
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
			}
			--
			require('mason').setup()
			require('mason-lspconfig').setup()
			for server_name, server_config in pairs(servers) do
				vim.lsp.config(server_name,server_config)
			end
		end
	}
