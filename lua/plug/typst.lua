-- return
-- {
--   'kaarmu/typst.vim',
--   enabled = false,
--   ft = { 'typst', 'typ' },
--   lazy = true,
--   config = function()
--     vim.g.typst_cmd = 'typst'
--     -- vim.g.typst_cmd = "python -m typst_pyimage"
--     vim.g.typst_pdf_viewer = 'zathura'
--   end,
-- }
return {
  "al-kot/typst-preview.nvim",
  config = function()

    require('typst-preview').setup()

    vim.keymap.set("n", "<leader>nts", function() require("typst-preview").start() end, { desc = "Start Typst preview" })
    vim.keymap.set("n", "<leader>ntq", function() require("typst-preview").stop() end, { desc = "Stop Typst preview" })
    vim.keymap.set("n", "<leader>ntn", function() require("typst-preview").next_page() end, { desc = "Next page" })
    vim.keymap.set("n", "<leader>ntp", function() require("typst-preview").prev_page() end, { desc = "Previous page" })
    vim.keymap.set("n", "<leader>ntr", function() require("typst-preview").refresh() end, { desc = "Refresh preview" })
    vim.keymap.set("n", "<leader>ntb", function() require("typst-preview").first_page() end, { desc = "First page" })
    vim.keymap.set("n", "<leader>nte", function() require("typst-preview").last_page() end, { desc = "Last page" })
  end
}
