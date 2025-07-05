return {
  enabled = false,
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    -- Top Pickers & Explorer
  },
  config = function()
    function is_git_repo()
      vim.fn.system 'git rev-parse --is-inside-work-tree'
      return vim.v.shell_error == 0
    end

    function get_git_root()
      local dot_git_path = vim.fn.finddir('.git', '.;')
      return vim.fn.fnamemodify(dot_git_path, ':h')
    end

    function from_git_root()
      if is_git_repo() then
          return get_git_root()
      end
    end

    require('snacks').setup({
      -- sort = {
      -- default sort is by score, text length and index
      -- fields = { "left","score:desc","#text","index" },
      -- },
      picker = {
        files = {
          auto_confirm = false,
          sort = {
            fields = { "left", "score:desc", },
          },
          confirm = function(picker, item)
            print(item.item)
            picker:close()
            -- if item then
            --   vim.schedule(function()
            --     -- vim.cmd("edit " .. item)
            --     Snacks.picker.select(item)
            --   end)
            -- end
          end,
        }
      },
      explorer = {},
    })

    function find_files()
      require('snacks').picker.files(
        {
          confirm = function(picker, item)
            picker:close()
            -- print(vim.inspect(item))
            if item then
              vim.schedule(function()
                vim.cmd("edit " .. item._path)
              end)
            end
          end,
          cwd = from_git_root(),
          sort = {
            fields = {
              "left", "score:desc",
            }
          }
        })
    end


    -- vim.keymap.set({ "n" }, "<leader><space>", function() require 'snacks'.picker.smart() end, { desc = "Smart Find Files" })
    vim.keymap.set({ "n" }, "<leader>sb", function() require 'snacks'.picker.buffers() end, { desc = "Buffers" })
    vim.keymap.set({ "n" }, "<leader>sw", function() require 'snacks'.picker.grep() end, { desc = "Grep" })
    -- vim.keymap.set({ "n" }, "<leader>:", function() require 'snacks'.picker.command_history() end, { desc = "Command History" })
    -- vim.keymap.set({ "n" }, "<leader>sN", function() require 'snacks'.picker.notifications() end, { desc = "Notification History" })
    vim.keymap.set({ "n" }, "<leader>E", function() require 'snacks'.explorer() end, { desc = "File Explorer" })
    -- find
    vim.keymap.set({ "n" }, "<leader>sn", function() require 'snacks'.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
    vim.keymap.set({ "n" }, "<leader>sf", function() find_files() end, { desc = "Find Files" })
    vim.keymap.set({ "n" }, "<leader>sg", function() require 'snacks'.picker.git_files() end, { desc = "Find Git Files" })
    vim.keymap.set({ "n" }, "<leader>sp", function() require 'snacks'.picker.projects() end, { desc = "Projects" })
    vim.keymap.set({ "n" }, "<leader>sr", function() require 'snacks'.picker.recent() end, { desc = "Recent" })
    -- git
    vim.keymap.set({ "n" }, "<leader>gb", function() require 'snacks'.picker.git_branches() end, { desc = "Git Branches" })
    vim.keymap.set({ "n" }, "<leader>gl", function() require 'snacks'.picker.git_log() end, { desc = "Git Log" })
    vim.keymap.set({ "n" }, "<leader>gL", function() require 'snacks'.picker.git_log_line() end, { desc = "Git Log Line" })
    vim.keymap.set({ "n" }, "<leader>gs", function() require 'snacks'.picker.git_status() end, { desc = "Git Status" })
    vim.keymap.set({ "n" }, "<leader>gS", function() require 'snacks'.picker.git_stash() end, { desc = "Git Stash" })
    vim.keymap.set({ "n" }, "<leader>gd", function() require 'snacks'.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
    vim.keymap.set({ "n" }, "<leader>gf", function() require 'snacks'.picker.git_log_file() end, { desc = "Git Log File" })
    -- Grep
    -- vim.keymap.set({ "n" }, "<leader>sb", function() require 'snacks'.picker.lines() end, { desc = "Buffer Lines" })
    -- vim.keymap.set({ "n" }, "<leader>sB", function() require 'snacks'.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
    -- vim.keymap.set({ "n" }, "<leader>sg", function() require 'snacks'.picker.grep() end, { desc = "Grep" })
    -- vim.keymap.set({"n"}, "<leader>sw",      function() require'snacks'.picker.grep_word() end,                                      desc = "Visual selection or word", mode = { "n",{ "x" } })
    -- search
    -- vim.keymap.set({ "n" }, '<leader>s"', function() require 'snacks'.picker.registers() end, { desc = "Registers" })
    -- vim.keymap.set({ "n" }, '<leader>s/', function() require 'snacks'.picker.search_history() end, { desc = "Search History" })
    -- vim.keymap.set({ "n" }, "<leader>sa", function() require 'snacks'.picker.autocmds() end, { desc = "Autocmds" })
    -- vim.keymap.set({ "n" }, "<leader>sb", function() require 'snacks'.picker.lines() end, { desc = "Buffer Lines" })
    -- vim.keymap.set({ "n" }, "<leader>sc", function() require 'snacks'.picker.command_history() end, { desc = "Command History" })
    -- vim.keymap.set({ "n" }, "<leader>sC", function() require 'snacks'.picker.commands() end, { desc = "Commands" })
    vim.keymap.set({ "n" }, "<leader>sd", function() require 'snacks'.picker.diagnostics() end, { desc = "Diagnostics" })
    vim.keymap.set({ "n" }, "<leader>sD", function() require 'snacks'.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
    vim.keymap.set({ "n" }, "<leader>sh", function() require 'snacks'.picker.help() end, { desc = "Help Pages" })
    vim.keymap.set({ "n" }, "<leader>sH", function() require 'snacks'.picker.highlights() end, { desc = "Highlights" })
    vim.keymap.set({ "n" }, "<leader>si", function() require 'snacks'.picker.icons() end, { desc = "Icons" })
    vim.keymap.set({ "n" }, "<leader>sj", function() require 'snacks'.picker.jumps() end, { desc = "Jumps" })
    vim.keymap.set({ "n" }, "<leader>sk", function() require 'snacks'.picker.keymaps() end, { desc = "Keymaps" })
    vim.keymap.set({ "n" }, "<leader>sl", function() require 'snacks'.picker.loclist() end, { desc = "Location List" })
    vim.keymap.set({ "n" }, "<leader>sm", function() require 'snacks'.picker.marks() end, { desc = "Marks" })
    vim.keymap.set({ "n" }, "<leader>sM", function() require 'snacks'.picker.man() end, { desc = "Man Pages" })
    vim.keymap.set({ "n" }, "<leader>sp", function() require 'snacks'.picker.lazy() end, { desc = "Search for Plugin Spec" })
    vim.keymap.set({ "n" }, "<leader>sq", function() require 'snacks'.picker.qflist() end, { desc = "Quickfix List" })
    vim.keymap.set({ "n" }, "<leader>sR", function() require 'snacks'.picker.resume() end, { desc = "Resume" })
    vim.keymap.set({ "n" }, "<leader>su", function() require 'snacks'.picker.undo() end, { desc = "Undo History" })
    -- vim.keymap.set({ "n" }, "<leader>uC", function() require 'snacks'.picker.colorschemes() end, { desc = "Colorschemes" })
    -- LSP
    -- vim.keymap.set({ "n" }, "gd", function() require 'snacks'.picker.lsp_definitions() end, { desc = "Goto Definition" })
    -- vim.keymap.set({ "n" }, "gD", function() require 'snacks'.picker.lsp_declarations() end, { desc = "Goto Declaration" })
    -- vim.keymap.set({"n"}, "gr",              function() require'snacks'.picker.lsp_references() end,                                 nowait = true,{                     desc = "References" })
    -- vim.keymap.set({ "n" }, "gI", function() require 'snacks'.picker.lsp_implementations() end, { desc = "Goto Implementation" })
    -- vim.keymap.set({ "n" }, "gy", function() require 'snacks'.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
    -- vim.keymap.set({ "n" }, "<leader>ss", function() require 'snacks'.picker.lsp_symbols() end, { desc = "LSP Symbols" })
    -- vim.keymap.set({ "n" }, "<leader>sS", function() require 'snacks'.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
  end
}
