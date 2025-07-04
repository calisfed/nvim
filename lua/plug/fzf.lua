return {
  enabled = false,
  lazy = false,
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {
      keymap = {
        builtin = {
          ["<Esc>"] = "abort",
        }
      },
      winops = {
        border = 'single',
        preview = {
          border = 'single',
          winopts = {
            number = true,
            relativenumber = true,
          }
        },
        -- on_create = function ()
        --   vim.b.completion = true
        -- end
      },
      fzf_opts = {
        ['--layout'] = 'default', -- reverse is default
        -- ['--scheme'] = 'path',
        ['--tiebreak'] = 'begin,length,index',
      },
      files = {
        no_ignore = true, -- respect ".gitignore"  by default
        -- prompt = "",
        cwd_prompt = false,
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
    vim.keymap.set({ 'n', 'v' }, '<leader>ss', function() require('fzf-lua').files(from_git_root()) end, { desc = 'Search Files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sg', function() require('fzf-lua').live_grep(from_git_root()) end, { desc = 'Search Files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', function() require('fzf-lua').grep_cword(from_git_root()) end, { desc = 'Search Files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sf', '<cmd>FzfLua git_files<CR>', { desc = 'Search Files' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>sw', '<cmd>FzfLua grep_cword<CR>', { desc = 'Search current Word' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>sg', '<cmd>FzfLua live_grep<CR>', { desc = 'Search by Grep' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', { desc = 'Search Diagnostics' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sr', '<cmd>FzfLua resume<cr>', { desc = 'Search Resume' })
    vim.keymap.set({ 'n', 'v' }, '<leader>s.', '<cmd>FzfLua oldfiles<cr>', { desc = 'Search Recent Files ("." for repeat)' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader><leader>', '<cmd>FzfLua buffers<cr>', { desc = '  Find existing buffers' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sn', '<cmd>FzfLua files cwd=$HOME/.config/nvim/<CR>', { desc = 'Search Neovim files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sa', '<cmd>FzfLua<cr>', { desc = 'All search' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cd', '<cmd>FzfLua lsp_definitions<cr>', { desc = 'Code go to Definitions' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ct', '<cmd>FzfLua lsp_type_definitions<cr>', { desc = 'Code go to Type definitions' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cr', '<cmd>FzfLua lsp_references<cr>', { desc = 'Code go to References' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cD', '<cmd>FzfLua lsp_document_diagnostics<cr>', { desc = 'Code list Diagnostics' })
    vim.keymap.set({ 'n', 'v' }, 'gd', '<cmd>FzfLua lsp_definitions<cr>', { desc = 'Goto Definition' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>FzfLua lsp_code_actions<cr>', { desc = 'Code Action' })
  end,
}
