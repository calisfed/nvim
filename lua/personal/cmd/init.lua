local M = { enabled = false }

M.opts = {
  cmdline = { keymaps = { edit = "<Esc>", execute = "<CR>", close = { "<C-C>","<Esc>" } } },
  win_config = function()
    return {
      relative = "editor",
      zindex = 250,
      row = vim.o.lines - vim.o.cmdheight,
      col = 0,
      style = "minimal",
      width = vim.o.columns,
      height = 1,
      border = 'none',
    }
  end,
}


local cmdline = require('lua.personal.cmd.cmdline')

function M.setup(opts)
  -- opts = vim.tbl_deep_extend("force", M.opts, opts) -- turn this on if want to config in init.lua
  opts = M.opts
  cmdline.setup(opts.cmdline)
  M.ns = vim.api.nvim_create_namespace("ed-cmd")
  M.attach()
end

function M.attach()
  vim.ui_attach(M.ns, { ext_cmdline = true, ext_popupmenu = false }, function(event, ...)
    if event:match("cmd") ~= nil then
      cmdline.handler(event, ...)
    end
  end)
end

return M
