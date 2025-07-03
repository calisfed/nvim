return {
    "max397574/better-escape.nvim",
  event = "VeryLazy",
    enabled = false,
    opst = function ()
      local config = {
      timeout = vim.o.timeoutlen,
      default_mappings = true,
      mappings = {
        i = { j = { k = "<Esc>", j = "<Esc>", }, },
        c = { j = { k = "<Esc>", j = "<Esc>", }, },
        t = { j = { k = "<Esc>", j = "<Esc>", }, },
        v = { j = { k = "<Esc>", }, },
        s = { j = { k = "<Esc>", }, },
      },
    }
    return config
    end
  }
