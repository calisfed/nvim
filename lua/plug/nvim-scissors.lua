return {
  enabled = false,
  "chrisgrieser/nvim-scissors",
  -- dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
  cmd = {'ScissorsEditSnippet', 'ScissorsAddNewSnippet'},
  opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
  },
}

