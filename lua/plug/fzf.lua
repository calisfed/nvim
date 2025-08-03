return {
  enabled = false,
  lazy = false,
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {
      { 'ivy' },
      keymap = {
        -- Below are the default binds, setting any value in these tables will override
        -- the defaults, to inherit from the defaults change [1] from `false` to `true`
        -- builtin = {
        --   -- neovim `:tmap` mappings for the fzf win
        --   -- true,        -- uncomment to inherit all the below in your custom config
        -- ["<Esc>"]      = 'abort',
        --   ["<M-Esc>"]    = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
        --   ["<F1>"]       = "toggle-help",
        --   ["<F2>"]       = "toggle-fullscreen",
        --   -- Only valid with the 'builtin' previewer
        --   ["<F3>"]       = "toggle-preview-wrap",
        --   ["<F4>"]       = "toggle-preview",
        --   -- Rotate preview clockwise/counter-clockwise
        --   ["<F5>"]       = "toggle-preview-ccw",
        --   ["<F6>"]       = "toggle-preview-cw",
        --   -- `ts-ctx` binds require `nvim-treesitter-context`
        --   ["<F7>"]       = "toggle-preview-ts-ctx",
        --   ["<F8>"]       = "preview-ts-ctx-dec",
        --   ["<F9>"]       = "preview-ts-ctx-inc",
        --   ["<S-Left>"]   = "preview-reset",
        --   ["<C-d>"]   = "preview-page-down",
        --   ["<C-u>"]     = "preview-page-up",
        --   -- [""] = "preview-down",
        --   -- ["<M-S-up>"]   = "preview-up",
        -- },
        -- fzf = {
        --   -- fzf '--bind=' options
        --   -- true,        -- uncomment to inherit all the below in your custom config
        --   ["ctrl-z"]     = "abort",
        --   ["ctrl-u"]     = "unix-line-discard",
        --   ["ctrl-f"]     = "half-page-down",
        --   ["ctrl-b"]     = "half-page-up",
        --   ["ctrl-a"]     = "beginning-of-line",
        --   ["ctrl-e"]     = "end-of-line",
        --   ["alt-a"]      = "toggle-all",
        --   ["alt-g"]      = "first",
        --   ["alt-G"]      = "last",
        --   -- Only valid with fzf previewers (bat/cat/git/etc)
        --   ["f3"]         = "toggle-preview-wrap",
        --   ["f4"]         = "toggle-preview",
        --   ["shift-down"] = "preview-page-down",
        --   ["shift-up"]   = "preview-page-up",
        -- },
      },
      previewers = {
        builtin = {
          extentions = {
            ['png'] = { 'ueberzugpp' },
            ['jpg'] = { 'ueberzugpp' },
            ['svg'] = { 'ueberzugpp' },
          }

        }

      },
      winopts = {
        preview = {
          winopts = {
            number = true,
            relativenumber = true,
          }
        },
        height = 0.3,
      },
      fzf_opts = {
        -- ['--layout'] = 'default', -- reverse is default
        -- ['--scheme'] = 'path',
        ['--tiebreak'] = 'begin,length,index',
      },
      files = {
        no_ignore  = true, -- respect ".gitignore"  by default
        -- prompt = "",

        -- formatter  = "path.filename_first",
        cwd_prompt = false,
        fd_opts    = [[--color=never --hidden --type f --type l --exclude .git]],
      },
      grep = {
        prompt = "Grep >"
      }
    }


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
        }
      end
      return opts
    end


    vim.keymap.set({ 'n', 'v' }, '<leader>sh', '<cmd>FzfLua help_tags<CR>', { desc = 'Search Help' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sk', '<cmd>FzfLua keymaps<CR>', { desc = 'Search Keymaps' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>ss', '<cmd>FzfLua files<CR>', { desc = 'Search Files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sf', function() require('fzf-lua').files(from_git_root()) end, { desc = 'Search Files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sg', function() require('fzf-lua').live_grep(from_git_root()) end, { desc = 'Search Grep' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>sw', function() require('fzf-lua').grep_cword(from_git_root()) end, { desc = 'Search cword' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sG', '<cmd>FzfLua git_files<CR>', { desc = 'Search Git files' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>sw', '<cmd>FzfLua grep_cword<CR>', { desc = 'Search current Word' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>sg', '<cmd>FzfLua live_grep<CR>', { desc = 'Search by Grep' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', { desc = 'Search Diagnostics' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sr', '<cmd>FzfLua resume<cr>', { desc = 'Search Resume' })
    vim.keymap.set({ 'n', 'v' }, '<leader>s.', '<cmd>FzfLua oldfiles<cr>', { desc = 'Search Recent Files ("." for repeat)' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader><leader>', '<cmd>FzfLua buffers<cr>', { desc = '  Find existing buffers' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sn', '<cmd>FzfLua files cwd=$HOME/.config/nvim/<CR>', { desc = 'Search Neovim files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sa', '<cmd>FzfLua<cr>', { desc = 'All search' })
    vim.keymap.set({ 'n', 'v' }, '<leader>scd', '<cmd>FzfLua lsp_definitions<cr>', { desc = 'Code go to Definitions' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sct', '<cmd>FzfLua lsp_type_definitions<cr>', { desc = 'Code go to Type definitions' })
    vim.keymap.set({ 'n', 'v' }, '<leader>scr', '<cmd>FzfLua lsp_references<cr>', { desc = 'Code go to References' })
    vim.keymap.set({ 'n', 'v' }, '<leader>scD', '<cmd>FzfLua lsp_document_diagnostics<cr>', { desc = 'Code list Diagnostics' })
    vim.keymap.set({ 'n', 'v' }, 'gd', '<cmd>FzfLua lsp_definitions<cr>', { desc = 'Goto Definition' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sca', '<cmd>FzfLua lsp_code_actions<cr>', { desc = 'Code Action' })
  end,
}
