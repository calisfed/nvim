return
-- -- install without yarn or npm
-- {
--     "iamcco/markdown-preview.nvim",
--     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--     ft = { "markdown" },
--     build = function() vim.fn["mkdp#util#install"]() end,
-- }

--  install with yarn or npm
{
  enabled = false,
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  opts = function()
    local config = {}
    vim.g.mkdp_browser = "qutebrowser %"
    return config
  end
}
