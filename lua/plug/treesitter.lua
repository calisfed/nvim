return { -- Treesitter
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  enabled = false,
  branch = 'main',
  -- event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      enabled = false,
    },
    {
      enabled = true,
      "nvim-treesitter/nvim-treesitter-context",
      opts = function()
        vim.keymap.set("n", "<leader>tc", "<cmd>lua require'treesitter-context'.toggle()<cr>", { desc = "Toggle TS Context" })
        local config = {
          enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 3,           -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 3, -- Maximum number of lines to show for a single context
          trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20,     -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        }
        -- vim.keymap.set("n", "[C", function()
        --   require("treesitter-context").go_to_context(vim.v.count1)
        -- end, { desc = "Back to [C]ontext", silent = true })

        -- require("treesitter-context").setup(config)

        return config
      end,
    },

    { 'luckasRanarison/tree-sitter-hyprlang',        enabled = true },
    { 'JoosepAlviste/nvim-ts-context-commentstring', enabled = false },

  },
  build = ':TSUpdate',
  config = function()
    vim.filetype.add {
      extension = { rasi = 'rasi' },
      pattern = {
        ['.*/waybar/config'] = 'jsonc',
        ['.*/mako/config'] = 'dosini',
        ['.*/hypr/.*.conf'] = 'hyprlang',
        ['.*/kitty/*.conf'] = 'bash',
      },
    }

    require('nvim-treesitter').setup({
      -- Directory to install parsers and queries to
      -- install_dir = vim.fn.stdpath('data') .. '/site'
    })
    require('nvim-treesitter').install({ 'c', 'lua', 'python', 'vimdoc', 'vim', 'bash', 'zig', 'markdown', 'markdown_inline'})

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '<filetype>' },
      callback = function()
        -- Highlight feature
        vim.treesitter.start()
        -- Indent feature
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        -- Fold feature
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      end,
    })

    -- Custom languages, check readme or help for more
    -- vim.api.nvim_create_autocmd('User', {
    --   pattern = 'TSUpdate',
    --   callback = function()
    --     require('nvim-treesitter.parsers').zimbu = {
    --       install_info = {
    --         url = 'https://github.com/zimbulang/tree-sitter-zimbu',
    --         -- revision = <sha>, -- commit hash for revision to check out; HEAD if missing
    --         -- optional entries:
    --         branch = 'develop',   -- only needed if different from default branch
    --         location = 'parser',  -- only needed if the parser is in subdirectory of a "monorepo"
    --         generate = true,      -- only needed if repo does not contain pre-generated `src/parser.c`
    --         generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
    --         queries = 'queries/neovim', -- also install queries from given directory
    --       },
    --     }
    --   end
    -- })
  end,
}





-- Old Treesitter config / migrating between master and main branch,
-- TODO: delete in future

---@diagnostic disable-next-line: missing-fields
-- require('nvim-treesitter').setup {
--   modules = {},
--   sync_install = true,
--   ignore_install = {},
--   -- Add languages to be installed here that you want installed for treesitter
--   ensure_installed = { 'c', 'lua', 'python', 'vimdoc', 'vim', 'bash', 'zig' },
--   -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
--   auto_install = true,

--   highlight = {
--     enable = true,
--     disable = function(lang, buf)
--       local max_filesize = 100 * 1024 -- 100 KB
--       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--       if ok and stats and stats.size > max_filesize then
--         return true
--       end
--     end,
--   },
--   indent = { enable = true },
--   incremental_selection = {
--     enable = false,
--     keymaps = {
--       init_selection = '<S-space>',
--       node_incremental = '<c-space>',
--       scope_incremental = '<c-s>',
--       node_decremental = '<M-space>',
--     },
--   },
--   textobjects = {
--     lsp_interop = {
--       enable = true,
--       border = 'rounded',
--       floating_preview_opts = {},
--       peek_definition_code = {
--         ['<leader>cp'] = '@function.outer',
--         ['<leader>cC'] = '@class.outer',
--       },
--     },
--     -- select = {
--     --   enable = false,
--     --   lookahead = true,         -- Automatically jump forward to textobj, similar to targets.vim
--     --   keymaps = {
--     --     -- You can use the capture groups defined in textobjects.scm
--     --     ['aa'] = { query = '@parameter.outer', desc = 'Parameter outer' },
--     --     ['ia'] = { query = '@parameter.inner', desc = 'Parameter inner' },
--     --     ['af'] = { query = '@function.outer', desc = 'Function outer' },
--     --     ['if'] = { query = '@function.inner', desc = 'Function inner' },
--     --     ['ac'] = { query = '@class.outer', desc = 'Class outer' },
--     --     ['ic'] = { query = '@class.inner', desc = 'Class inner' },
--     --   },
--     -- },
--     -- move = {
--     --   enable = false,
--     --   set_jumps = true,         -- whether to set jumps in the jumplist
--     --   goto_next_start = {
--     --     [']m'] = { query = '@function.outer', desc = 'Next method start' },
--     --     [']]'] = { query = '@class.outer', desc = 'Next class start' },
--     --     [']a'] = { query = '@parameter.inner', desc = 'Next parameter start' },
--     --     [']A'] = { query = '@assignment.rhs', desc = 'Next assignment rhs' },
--     --     [']c'] = { query = '@block.outer', desc = 'Block' },
--     --   },
--     --   goto_next_end = {
--     --     [']M'] = { query = '@function.outer', desc = 'Next method end' },
--     --     [']['] = { query = '@class.outer', desc = 'Next class end' },
--     --   },
--     --   goto_previous_start = {
--     --     ['[m'] = { query = '@function.outer', desc = 'Previous method start' },
--     --     ['[['] = { query = '@class.outer', desc = 'Previous class start' },
--     --     ['[a'] = { query = '@parameter.inner', desc = 'Previous parameter end' },
--     --     ['[A'] = { query = '@assignment.rhs', desc = 'Previous assignment rhs' },
--     --   },
--     --   goto_previous_end = {
--     --     ['[M'] = { query = '@function.outer', desc = 'Previous method end' },
--     --     ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
--     --   },
--     -- },
--     --        swap = {
--     --         enable = true,
--     --         swap_next = {
--     --           ['<leader>a'] = '@parameter.inner',
--     --         },
--     --         swap_previous = {
--     --           ['<leader>A'] = '@parameter.inner',
--     --         },
--     --       },
--   },
-- }
