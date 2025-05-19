
return {
  'uga-rosa/ccc.nvim',
  event = "VeryLazy",
  -- enabled = false,
  config = function ()
    vim.opt.termguicolors = true

    local ccc = require("ccc")
    local mapping = ccc.mapping

    ccc.setup({
      -- Your preferred settings
      -- Example: enable highlighter
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })
  end,
}
