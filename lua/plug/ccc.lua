return {
  enabled = false,
  'uga-rosa/ccc.nvim',
  event = "VeryLazy",
  -- enabled = false,
  opts = function ()
    vim.opt.termguicolors = true

    -- local ccc = require("ccc")
    -- local mapping = ccc.mapping

    local config = {
      -- Your preferred settings
      -- Example: enable highlighter
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    }
    return config
  end,
}
