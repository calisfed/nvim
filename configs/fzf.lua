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
    opts = { cwd = get_git_root() }
  end
  return opts
end

require("fzf-lua").setup({
  winopts = {
    border = { '', '-', '', '', '', '', '', '' },
    height = 0.3, -- or 1.0 for full screen
    width = 1.0,
    row = 1,      -- anchor to bottom
    col = 0,
    preview = {
      hidden = 'hidden',
      -- layout = 'vertical',
      -- vertical = 'up:60%',
      number = true,
      relativenumber = true
    }
  },
  fzf_opts = {
    ["--layout"] = "default", -- puts prompt at bottom
    ["--no-height"] = "",     -- allow fzf to expand fully
    ["--tiebreak"] = 'begin,length,index'
  },
  files = {
    prompt = false,
    formatter = "path.filename_first"
    -- cwd_prompt = false,
  },
  git = {
    prompt = false,
    files = {
      formatter = "path.filename_first"
    },
  },
  buffers = {
    prompt = false,
    actions = false,
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader>sh', '<cmd>FzfLua help_tags<CR>', { desc = 'Search Help' })
vim.keymap.set({ 'n', 'v' }, '<leader>sk', '<cmd>FzfLua keymaps<CR>', { desc = 'Search Keymaps' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>ss', '<cmd>FzfLua files<CR>', { desc = 'Search Files' })
vim.keymap.set({ 'n', 'v' }, '<leader>sf', function ()
  require('fzf-lua').files(from_git_root())
end, { desc = 'Search Files' }
)
vim.keymap.set({ 'n', 'v' }, '<leader>sg', function ()
  require('fzf-lua').live_grep(from_git_root())
end, { desc = 'Search Grep' }
)
-- vim.keymap.set({ 'n', 'v' }, '<leader>sw', function() require('fzf-lua').grep_cword(from_git_root()) end, { desc = 'Search cword' })
vim.keymap.set({ 'n', 'v' }, '<leader>sG', '<cmd>FzfLua git_files<CR>', {
  desc = 'Search Git files'
})
vim.keymap.set({ 'n', 'v' }, '<leader>sw', '<cmd>FzfLua grep_cword<CR>', { desc = 'Search current Word' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>sg', '<cmd>FzfLua live_grep<CR>', { desc = 'Search by Grep' })
vim.keymap.set({ 'n', 'v' }, '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', {
  desc = 'Search Diagnostics'
})
vim.keymap.set({ 'n', 'v' }, '<leader>sr', '<cmd>FzfLua resume<cr>', { desc = 'Search Resume' })
vim.keymap.set({ 'n', 'v' }, '<leader>s.', '<cmd>FzfLua oldfiles<cr>', {
  desc = 'Search Recent Files ("." for repeat)'
})
vim.keymap.set({ 'n', 'v' }, '<leader><leader>', '<cmd>FzfLua buffers<cr>', { desc = '  Find existing buffers' })
vim.keymap.set(
  { 'n', 'v' }, '<leader>sn', '<cmd>FzfLua files cwd=$HOME/.config/nvim/<CR>', { desc = 'Search Neovim files' }
)
vim.keymap.set({ 'n', 'v' }, '<leader>sa', '<cmd>FzfLua<cr>', { desc = 'All search' })
vim.keymap.set({ 'n', 'v' }, '<leader>scd', '<cmd>FzfLua lsp_definitions<cr>', {
  desc = 'Code go to Definitions'
})
vim.keymap.set(
  { 'n', 'v' }, '<leader>sct', '<cmd>FzfLua lsp_type_definitions<cr>', { desc = 'Code go to Type definitions' }
)
vim.keymap.set({ 'n', 'v' }, '<leader>scr', '<cmd>FzfLua lsp_references<cr>', {
  desc = 'Code go to References'
})
vim.keymap.set(
  { 'n', 'v' }, '<leader>scD', '<cmd>FzfLua lsp_document_diagnostics<cr>', { desc = 'Code list Diagnostics' }
)
vim.keymap.set({ 'n', 'v' }, 'gd', '<cmd>FzfLua lsp_definitions<cr>', { desc = 'Goto Definition' })
vim.keymap.set({ 'n', 'v' }, '<leader>sca', '<cmd>FzfLua lsp_code_actions<cr>', {
  desc = 'Code Action'
})
