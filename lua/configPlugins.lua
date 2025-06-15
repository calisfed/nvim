return {
  -- Colorscheme

  { enabled = true,  'EdenEast/nightfox.nvim',                   priority = 1000, },
  { enabled = true,  'diegoulloao/neofusion.nvim',               priority = 1000, },
  { enabled = true,  'eldritch-theme/eldritch.nvim',             priority = 1000, },
  { enabled = false, 'folke/tokyonight.nvim',                    priority = 1000, },
  { enabled = false, 'olivercederborg/poimandres.nvim',          priority = 1000, },
  { enabled = false, 'rose-pine/neovim',                         priority = 1000, name = 'rose-pine', },
  { enabled = false, 'sainnhe/sonokai',                          priority = 1000, },
  { enabled = false, "rktjmp/lush.nvim", }, -- interactive, create own colorscheme

  -- Core

  { enabled = true,  'neovim/nvim-lspconfig', },           -- lspconfig
  { enabled = true,  'nvim-treesitter/nvim-treesitter', }, -- color text
  { enabled = true,  'nvim-telescope/telescope.nvim', },   -- lua fzf search
  { enabled = true,  'aaronik/treewalker.nvim', },         -- move around with code syntax aware
  { enabled = false, 'nvimdev/lspsaga.nvim', },            -- nany config, features for lsp


  -- Plugins that many others require

  { enabled = true,  'MunifTanjim/nui.nvim' },   -- UI components library, it is not meant to run/config itself, but by other plugins
  { enabled = true,  'nvim-lua/plenary.nvim' },  --
  { enabled = true,  'nvim-neotest/nvim-nio', }, -- debug adapter protocol ui

  -- QoL
  { enabled = true,  "sindrets/diffview.nvim", },              -- Diff integration
  { enabled = true,  'echasnovski/mini.nvim', },               -- QoL plugins
  { enabled = true,  'stevearc/oil.nvim', },                   -- file explorer
  { enabled = true,  'jiaoshijie/undotree', },                 -- undo, but tree
  { enabled = true,  'lambdalisue/suda.vim', },                -- auto read/write file with sudo
  { enabled = true,  'jake-stewart/multicursor.nvim', },       -- multi cursor
  { enabled = true,  'hamidi-dev/kaleidosearch.nvim', },       -- color keyword
  { enabled = true,  'SunnyTamang/select-undo.nvim', },        -- select part to undo
  { enabled = true,  'HawkinsT/pathfinder.nvim', },            -- enhanced gf gF gx
  { enabled = true,  'leath-dub/snipe.nvim', },                -- fast buffer select
  { enabled = true,  'folke/todo-comments.nvim', },            -- color keywore
  { enabled = true,  'kawre/neotab.nvim', },                   -- tabout of parantheses
  { enabled = true,  'norcalli/nvim-colorizer.lua', },         -- show color
  { enabled = true,  'tridactyl/vim-tridactyl', },             -- tridactyl (Firefox extension)
  { enabled = true,  'shellRaining/hlchunk.nvim', },           -- highlight part of working code
  { enabled = true,  'danymat/neogen', },                      -- annotation toolkit
  { enabled = true,  'cksidharthan/mentor.nvim' },             -- random tips after open nvim
  { enabled = true,  'rubiin/fortune.nvim' },                  -- Inspiration and Wisdom quotes, go with dashboard plugins like mini or alpha
  { enabled = true,  'monaqa/dial.nvim' },                     -- increment/decrement base on various rules
  { enabled = true,  'folke/noice.nvim' },                     -- replace UI for messages, cmdline or popupmenu
  { enabled = false, 'folke/snacks.nvim' },                    -- QoL plugins
  { enabled = false, 'A7Lavinraj/fyler.nvim' },                -- like oil.nvim but have tree-view
  { enabled = false, 'Bilal2453/luvit-meta', },                -- part of lua dev
  { enabled = false, 'NStefan002/screenkey.nvim', },           -- show what key typing
  { enabled = false, 'akinsho/toggleterm.nvim', },             -- toggle terminal
  { enabled = false, 'emmanueltouzery/apidocs.nvim' },         -- devdocs.io integrated
  { enabled = false, 'kevinhwang91/nvim-ufo', },               -- fold
  { enabled = false, 'lewis6991/gitsigns.nvim', },             -- gitsigns
  { enabled = false, 'lukas-reineke/indent-blankline.nvim', }, -- highlight part of waking code
  { enabled = false, 'stevearc/conform.nvim', },               -- lightweight, powerful formatter
  { enabled = false, 'tpope/vim-sleuth', },                    -- auto adjust shiftwidth and expandtab
  { enabled = false, 'yarospace/lua-console.nvim', },          -- lua console
  { enabled = false, 'DanWlker/toolbox.nvim', },               -- place to put all custom function
  { enabled = false, 'DimitrisDimitropoulos/yasp.nvim', },     -- simple way to manage your snippets in a completion engine agnostic way
  { enabled = false, 'ThePrimeagen/harpoon', },                -- quick navigate with saved buffers
  { enabled = false, 'ThePrimeagen/refactoring.nvim' },        -- refactoring library based off the refactoring book
  { enabled = false, 'stevearc/overseer.nvim', },              -- a task runner and job management plugin for Neovim
  { enabled = false, 'stevearc/quicker.nvim', },               -- improved UI and workflow for the Neovim quickfix
  { enabled = false, 'abecodes/tabout.nvim', },                -- tabout of parantheses
  { enabled = false, 'altermo/ultimate-autopair.nvim' },       -- autopairs, replaced by mini.pair
  { enabled = false, 'folke/which-key.nvim', },                -- keymapping helper, currently replaced by mini.clue
  { enabled = false, 'goolord/alpha-nvim', },                  -- dashboard, replaced by mini.starter
  { enabled = false, 'max397574/better-escape.nvim', },        -- better Escape with jj, jk, ...., replaced by minmi.keymap
  { enabled = false, 'rmagatti/auto-session' },                -- session, replaced by mini.session
  { enabled = false, 'tris203/precognition.nvim', },           -- show movement keys
  { enabled = false, 'uga-rosa/ccc.nvim', },                   -- show color
  { enabled = false, 'windwp/nvim-autopairs' },                -- autopair,  replaced by mini.pair
  { enabled = false, 'xzbdmw/clasp.nvim' },                    -- autopair,  replaced by mini.pair
  { enabled = false, 'sQVe/sort.nvim', },                      -- sort, considering re-try
  { enabled = false, 'camerondixon/hex-reader.nvim' },         -- Hex reader
  { enabled = false, 'markgandolfo/lightswitch.nvim' },        -- Switch menu, require nui.nvim
  { enabled = false, 'ibhagwan/fzf-lua', },                    -- fzf search
  { enabled = true,  'chrisgrieser/nvim-scissors', },          -- Create and Edit snippet
  { enabled = true,  'NeogitOrg/neogit' },                     -- git integration



  -- html

  { enabled = true,  'windwp/nvim-ts-autotag' }, -- Auto close tag for htmlmtoc
  { enabled = false, 'rest-nvim/rest.nvim' },    -- Fast REST api

  -- Debugging

  { enabled = true,  'andrewferrier/debugprint.nvim', }, -- print debug statement instead of DAP
  { enabled = false, 'igorlfs/nvim-dap-view', },         -- DAP view replace ui
  { enabled = false, 'mfussenegger/nvim-dap', },         -- debug adapter protocol
  { enabled = false, 'rcarriga/nvim-dap-ui', },          -- debug adapter protocol ui
  { enabled = false, 'jay-babu/mason-nvim-dap.nvim', },  -- Mason integration
  { enabled = false, "miroshQa/debugmaster.nvim", },     -- dap-ui alternative, aka adebug mode

  -- Completion

  { enabled = true,  'saghen/blink.cmp', },                       -- better completion
  { enabled = false, 'Dan7h3x/signup.nvim', },                    -- LSP Sign help
  { enabled = false, 'ZWindL/orphans.nvim', },                    -- check if plugins haven't been update for a while
  { enabled = false, 'folke/lazydev.nvim', },                     -- lua dev
  { enabled = false, 'hrsh7th/nvim-cmp', },                       -- completion
  { enabled = false, 'iguanacucumber/magazine.nvim' },            -- nvim-cmp but with patches
  { enabled = false, 'rachartier/tiny-code-action.nvim', },       -- require telescope/fzf for code actions
  { enabled = false, 'rachartier/tiny-inline-diagnostic.nvim', }, -- inline diagnostic

  -- Note

  { enabled = true,  'brianhuster/live-preview.nvim' },             -- live preview html asciidoc svg
  { enabled = true,  '3rd/image.nvim', },                           -- show image in neovim with kitty  protocol or uebzugpp
  { enabled = true,  'jbyuki/nabla.nvim', },                        -- take scientific note (like formula), math
  { enabled = true,  'jbyuki/venn.nvim', },                         -- drawing diagram, pretty fun
  { enabled = true,  'Myzel394/easytables.nvim', },                 -- markdown table,WIP
  { enabled = true,  'vidocqh/data-viewer.nvim', },                 -- Lightweight neovim plugin provides a table view for inspect data files such as csv, tsv
  { enabled = true,  'HakonHarnes/img-clip.nvim', },                -- Effortlessly embed images into any markup language,like LaTeX, Markdown or Typst.
  { enabled = true,  'jghauser/follow-md-links.nvim' },             -- follow markdown links, paths, refs,...
  { enabled = true,  'tigion/nvim-asciidoc-preview' },              -- Asciidoc preview, will back in future
  { enabled = true,  'chrisbra/unicode.vim' },                      -- enter unicode
  { enabled = true,  'gu-fan/easydigraph.vim' },                    -- some digraph
  { enabled = false, 'OXY2DEV/markview.nvim', },                    -- A hackable Markdown,HTML,LaTeX, Typst & YAML previewer for Neovim.
  { enabled = false, 'hedyhli/markdown-toc.nvim', },                -- A hackable Markdown,HTML,LaTeX, Typst & YAML previewer for Neovim.
  { enabled = false, 'chomosuke/typst-preview.nvim', },             -- typst preview
  { enabled = false, 'iamcco/markdown-preview.nvim' },              -- markdown preview on browser
  { enabled = true,  'nvim-neorg/neorg', },                         -- USAGE organize, replaced by above plugins, currently not use because of export not good
  { enabled = false, 'nvim-telekasten/telekasten.nvim' },           -- zettekasten for neovim, only drawback is telescope
  { enabled = false, 'nvim-telekasten/calendar-vim' },              -- addon for telekasten
  { enabled = false, 'allaman/emoji.nvim' },                        -- Emoji insert
  { enabled = false, 'MeanderingProgrammer/render-markdown.nvim' }, -- improve viewing markdown in neovim, compare with markview but less support
  { enabled = false, 'kaarmu/typst.vim', },                         -- Note, can conceal, but let try markview first
  { enabled = false, 'hat0uma/csvview.nvim', },                     -- A comfortable CSV/TSV editing plugin for Neovim.
  { enabled = false, 'caliguIa/zendiagram.nvim' },                  -- A minimal, good looking diagnostic float window for Neovim.
  { enabled = false, 'marcocofano/excalidraw.nvim', },              -- A nvim plugin to help managing excalidraw diagrams in markdown files., WIP
  { enabled = false, 'obsidian-nvim/obsidian.nvim', },              -- Obsidian neovim
  { enabled = false, 'junegunn/limelight.vim', },                   -- hyper focus writing in neovim,highlight only the writing part
  { enabled = false, 'nvim-orgmode/orgmode', },                     -- USAGE organize, replaced by above plugins, use neorg
  { enabled = false, "pxwg/latex-conceal.nvim", },                  -- faster latex conceal
  { enabled = false, "lervag/vimtex" },                             -- for TEX writting

  -- Eye candy plugins, turn on when bored

  { enabled = false, 'iguanacucumber/highlight-actions.nvim' }, -- higlight action
  { enabled = false, 'tamton-aquib/duck.nvim', },               -- duck/dog/cat follow cursor
  { enabled = false, 'nvzone/volt', },                          -- from nvchad, tool for create interactive UI in neovim
  { enabled = false, 'nvzone/minty', },                         -- from nvchad, Beautifully crafted color tools for Neovim
  { enabled = false, 'nvzone/menu', },                          -- from nvchad, menu ui, supported nested menu, use mouse
  { enabled = false, 'nvzone/timerly', },                       -- from nvchad, eye candy interactive timer plugin
  { enabled = false, 'OXY2DEV/helpview.nvim', },                -- A hackable & fancy vimdoc viewer for Neovim.
  { enabled = false, 'meznaric/key-analyzer.nvim' },            -- analyze keymap used
  { enabled = false, 'sphamba/smear-cursor.nvim' },             -- smear cursor, currently using mini.animate
  { enabled = false, 'wildfunctions/myeyeshurt', },             -- resting eye after a while

}
