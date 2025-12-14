return {
  enabled = false,
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    -- Top Pickers & Explorer
  },
  config = function()
    require('snacks').setup({
      bigfile = { enabled = true },
      dim = {
        animated = false,
      },
      picker = {
        layout = { preset = 'ivy', layout = { height = 0.35, }, },
        win = { input = { keys = { ["<Esc>"] = { "close", mode = { "n", "i" } }, }, }, },
        sort = { fields = { "left", "score:desc", "#text", "idx" }, },
        man = {},
      },
      explorer = {},
      zen = {
        win = {
            enter = true,
            fixbuf = false,
            minimal = false,
            width = 150,
            height = 0,
            backdrop = { transparent = false, blend = 0 },
            keys = { q = false },
            zindex = 40,
            wo = {
              winhighlight = "NormalFloat:Normal",
            },
            w = {
              snacks_main = true,
            },
        }
      },

    })

    function find_files()
      require('snacks').picker.files({
        cwd = Snacks.git.get_root(),
        sort = {
          fields = {
            "left", "score:desc", "#text", "idx"
          }
        }
      })
    end

    vim.keymap.set({ "n" }, "<leader>ss", function() require 'snacks'.picker.smart() end,
      { desc = "Smart Find Files" })
    vim.keymap.set({ "n" }, "<leader>sa", function() require 'snacks'.picker.pickers() end,
      { desc = "Snacks Pickers" })
    vim.keymap.set({ "n" }, "<leader>sb", function() require 'snacks'.picker.buffers() end, { desc = "Buffers" })
    vim.keymap.set({ "n" }, "<leader>sg", function() require 'snacks'.picker.grep() end, { desc = "Grep" })
    vim.keymap.set({ "n" }, "<leader>:", function() require 'snacks'.picker.command_history() end,
      { desc = "Command History" })
    vim.keymap.set({ "n" }, "<leader>sN", function() require 'snacks'.picker.notifications() end,
      { desc = "Notification History" })
    vim.keymap.set({ "n" }, "<leader>E", function() require 'snacks'.explorer() end, { desc = "File Explorer" })
    -- find
    vim.keymap.set({ "n" }, "<leader>sn",
      function() require 'snacks'.picker.files({ cwd = vim.fn.stdpath("config") }) end,
      { desc = "Find Config File" })

    -- vim.keymap.set({ "n" }, "<leader>sf",
    --     function() require 'snacks'.picker.files({ cwd = Snacks.git.get_root(), sort = { fields = { "left", "score:desc" } } }) end,
    --     { desc = "Find Config File" })




    -- vim.keymap.set({ "n" }, "<leader>sf", function() require'snacks'.picker.files() end, { desc = "Find Files" })
    vim.keymap.set({ "n" }, "<leader>sf", function() find_files() end, { desc = "Find Files" })
    -- vim.keymap.set({ "n" }, "<leader>sg", function() require 'snacks'.picker.git_files() end, { desc = "Find Git Files" })
    vim.keymap.set({ "n" }, "<leader>sp", function() require 'snacks'.picker.projects() end, { desc = "Projects" })
    vim.keymap.set({ "n" }, "<leader>sr", function() require 'snacks'.picker.recent() end, { desc = "Recent" })
    -- git
    vim.keymap.set({ "n" }, "<leader>gg", function() require 'snacks'.lazygit() end, { desc = "Lazygit" })
    -- vim.keymap.set({ "n" }, "<leader>gb", function() require 'snacks'.picker.git_branches() end, { desc = "Git Branches" })
    -- vim.keymap.set({ "n" }, "<leader>gl", function() require 'snacks'.picker.git_log() end, { desc = "Git Log" })
    -- vim.keymap.set({ "n" }, "<leader>gL", function() require 'snacks'.picker.git_log_line() end, { desc = "Git Log Line" })
    -- vim.keymap.set({ "n" }, "<leader>gs", function() require 'snacks'.picker.git_status() end, { desc = "Git Status" })
    -- vim.keymap.set({ "n" }, "<leader>gS", function() require 'snacks'.picker.git_stash() end, { desc = "Git Stash" })
    -- vim.keymap.set({ "n" }, "<leader>gd", function() require 'snacks'.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
    -- vim.keymap.set({ "n" }, "<leader>gf", function() require 'snacks'.picker.git_log_file() end, { desc = "Git Log File" })
    -- Grep
    -- vim.keymap.set({ "n" }, "<leader>sb", function() require 'snacks'.picker.lines() end, { desc = "Buffer Lines" })
    -- vim.keymap.set({ "n" }, "<leader>sB", function() require 'snacks'.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
    -- vim.keymap.set({ "n" }, "<leader>sg", function() require 'snacks'.picker.grep() end, { desc = "Grep" })
    -- vim.keymap.set({"n"}, "<leader>sw",      function() require'snacks'.picker.grep_word() end,                                      desc = "Visual selection or word", mode = { "n",{ "x" } })
    -- search
    vim.keymap.set({ "n" }, '<leader>s"', function() require 'snacks'.picker.registers() end, { desc = "Registers" })
    -- vim.keymap.set({ "n" }, '<leader>s/', function() require 'snacks'.picker.search_history() end, { desc = "Search History" })
    -- vim.keymap.set({ "n" }, "<leader>sa", function() require 'snacks'.picker.autocmds() end, { desc = "Autocmds" })
    -- vim.keymap.set({ "n" }, "<leader>sb", function() require 'snacks'.picker.lines() end, { desc = "Buffer Lines" })
    -- vim.keymap.set({ "n" }, "<leader>sc", function() require 'snacks'.picker.command_history() end, { desc = "Command History" })
    -- vim.keymap.set({ "n" }, "<leader>sC", function() require 'snacks'.picker.commands() end, { desc = "Commands" })
    vim.keymap.set({ "n" }, "<leader>sd", function() require 'snacks'.picker.diagnostics() end,
      { desc = "Diagnostics" })
    vim.keymap.set({ "n" }, "<leader>sD", function() require 'snacks'.picker.diagnostics_buffer() end,
      { desc = "Buffer Diagnostics" })
    vim.keymap.set({ "n" }, "<leader>sh", function() require 'snacks'.picker.help() end, { desc = "Help Pages" })
    vim.keymap.set({ "n" }, "<leader>sH", function() require 'snacks'.picker.highlights() end,
      { desc = "Highlights" })
    vim.keymap.set({ "n" }, "<leader>si", function() require 'snacks'.picker.icons() end, { desc = "Icons" })
    vim.keymap.set({ "n" }, "<leader>sj", function() require 'snacks'.picker.jumps() end, { desc = "Jumps" })
    vim.keymap.set({ "n" }, "<leader>sk", function() require 'snacks'.picker.keymaps() end, { desc = "Keymaps" })
    vim.keymap.set({ "n" }, "<leader>sl", function() require 'snacks'.picker.loclist() end,
      { desc = "Location List" })
    vim.keymap.set({ "n" }, "<leader>sm", function() require 'snacks'.picker.marks() end, { desc = "Marks" })
    vim.keymap.set({ "n" }, "<leader>sM", function() require 'snacks'.picker.man() end, { desc = "Man Pages" })
    vim.keymap.set({ "n" }, "<leader>sP", function() require 'snacks'.picker.lazy() end,
      { desc = "Search for Plugin Spec" })
    vim.keymap.set({ "n" }, "<leader>sq", function() require 'snacks'.picker.qflist() end, { desc = "Quickfix List" })
    vim.keymap.set({ "n" }, "<leader>sR", function() require 'snacks'.picker.resume() end, { desc = "Resume" })
    vim.keymap.set({ "n" }, "<leader>su", function() require 'snacks'.picker.undo() end, { desc = "Undo History" })
    -- vim.keymap.set({ "n" }, "<leader>uC", function() require 'snacks'.picker.colorschemes() end, { desc = "Colorschemes" })
    -- LSP
    vim.keymap.set({ "n" }, "<leader>cd", function() require 'snacks'.picker.lsp_definitions() end,
      { desc = "Goto Definition" })
    vim.keymap.set({ "n" }, "<leader>cD", function() require 'snacks'.picker.lsp_declarations() end,
      { desc = "Goto Declaration" })
    vim.keymap.set({ "n" }, "<leader>cr", function() require 'snacks'.picker.lsp_references() end,
      { desc = "References" })
    vim.keymap.set({ "n" }, "<leader>ci", function() require 'snacks'.picker.lsp_implementations() end,
      { desc = "Goto Implementation" })
    vim.keymap.set({ "n" }, "<leader>ct", function() require 'snacks'.picker.lsp_type_definitions() end,
      { desc = "Goto T[y]pe Definition" })
    vim.keymap.set({ "n" }, "<leader>cs", function() require 'snacks'.picker.lsp_symbols() end, { desc = "LSP Symbols" })
    vim.keymap.set({ "n" }, "<leader>cS", function() require 'snacks'.picker.lsp_workspace_symbols() end,
      { desc = "LSP Workspace Symbols" })

    -- git
    vim.keymap.set({ "n" }, "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
    vim.keymap.set({ "n" }, "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
    vim.keymap.set({ "n" }, "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
    vim.keymap.set({ "n" }, "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
    vim.keymap.set({ "n" }, "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
    vim.keymap.set({ "n" }, "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
    vim.keymap.set({ "n" }, "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
    -- gh
    vim.keymap.set({ "n" }, "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
    vim.keymap.set({ "n" }, "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end,
      { desc = "GitHub Issues (all)" })
    vim.keymap.set({ "n" }, "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
    vim.keymap.set({ "n" }, "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,
      { desc = "GitHub Pull Requests (all)" })
    -- Other
    vim.keymap.set({ "n" }, "<leader>z", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
    vim.keymap.set({ "n" }, "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
    vim.keymap.set({ "n" }, "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
    vim.keymap.set({ "n" }, "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
    vim.keymap.set({ "n" }, "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
    vim.keymap.set({ "n" }, "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
    vim.keymap.set({ "n" }, "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
    vim.keymap.set({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
    vim.keymap.set({ "n" }, "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
    vim.keymap.set({ "n" }, "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
    vim.keymap.set({ "n" }, "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
    vim.keymap.set({ "n" }, "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })
  end
}
