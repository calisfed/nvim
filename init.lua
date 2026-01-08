vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  defaults = {
    lazy = true,
  },
  spec = {
    { import = "color" },
    { import = "plug" },
    { import = "cfg" },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true,      -- get a notification when new updates are found
    frequency = 3600,   -- check for updates every hour
    check_pinned = false, -- check for pinned packages that can't be updated
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,      -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {
      }, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  }
})

require('options')
require('autocmds')
require('keymaps')
require('cool.quickfix')
require('cool.close_qf_with_q')
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'TSUpdate',
--   callback = function()
--     require('nvim-treesitter.parsers').asciidoc = {
--       install_info = {
--         path = '~/.config/nvim/lua/personal/cpkio-asciidoc/',
-- --       location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
--       generate = true, -- only needed if repo does not contain pre-generated `src/parser.c`
--       generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
--       queries = 'queries', -- also install queries from given directory
--       },
--     }
--   end
-- })

vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').asciidoc = {
      install_info = {
        path = '~/.config/nvim/lua/personal/tree-sitter-asciidoc/tree-sitter-asciidoc/',
--       location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
      generate = false, -- only needed if repo does not contain pre-generated `src/parser.c`
      generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
      queries = 'queries', -- also install queries from given directory
      },
    }
  end
})


-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'TSUpdate',
--   callback = function()
--     require('nvim-treesitter.parsers').asciidoc_inline = {
--       install_info = {
--         path = '~/.config/nvim/lua/personal/tree-sitter-asciidoc/tree-sitter-asciidoc_inline/',
-- --       location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
--       generate = false, -- only needed if repo does not contain pre-generated `src/parser.c`
--       generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
--       queries = 'queries', -- also install queries from given directory
--       },
--     }
--   end
-- })

-- if vim.env.PROF then
--   -- example for lazy.nvim
--   -- change this to the correct path for your plugin manager
--   local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
--   vim.opt.rtp:append(snacks)
--   require("snacks.profiler").startup({
--     startup = {
--       event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
--       -- event = "UIEnter",
--       -- event = "VeryLazy",
--     },
--   })
-- end

-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "*",
-- 	group = "UserDefLoadOnce",
-- 	desc = "prevent colorscheme clears self-defined DAP icon colors.",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
-- 		vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
-- 		vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })
-- 	end
-- })

-- vim.fn.sign_define('DapBreakpoint', { text=' ', texthl='DapBreakpoint' })
-- vim.fn.sign_define('DapBreakpointCondition', { text=' ﳁ', texthl='DapBreakpoint' })
-- vim.fn.sign_define('DapBreakpointRejected', { text=' ', texthl='DapBreakpoint' })
-- vim.fn.sign_define('DapLogPoint', { text=' ', texthl='DapLogPoint' })
-- vim.fn.sign_define('DapStopped', { text=' ', texthl='DapStopped' })
