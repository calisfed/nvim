return {
  "rcarriga/nvim-dap-ui",
  enabled = false,
  cond = false,
  dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  config = function ()
    local dap = require("dap")
    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
          local name = vim.fn.input('Executable name (filter): ')
          return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}'
      },
    }
  end
}
-- return {
--   {
--     "mfussenegger/nvim-dap",
--     config = function()
--       local dap = require("dap")
--       -- Configure your debug adapters here
--       -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
--     end,
--   },
--   {
--     "miroshQa/debugmaster.nvim",
--     config = function()
--       local dm = require("debugmaster")
--       -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
--       vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
--       -- If you want to disable debug mode in addition to leader+d using the Escape key:
--       -- vim.keymap.set("n", "<Esc>", dm.mode.disable)
--       -- This might be unwanted if you already use Esc for ":noh"
--       vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", {desc = "Exit terminal mode"})
--     end
--   }
-- }
