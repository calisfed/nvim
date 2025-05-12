return
{
  'kaarmu/typst.vim',
  enabled = false,
  ft = { 'typst', 'typ' },
  lazy = true,
  config = function()
    vim.g.typst_cmd = 'typst'
    -- vim.g.typst_cmd = "python -m typst_pyimage"
    vim.g.typst_pdf_viewer = 'zathura'
  end,
}
