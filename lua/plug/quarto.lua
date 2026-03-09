return {
  enabled = false,
  lazy = false,
  ft = { "markdown", "quadro" },
  "quarto-dev/quarto-nvim",
  dependencies = {
    "jmbuhr/otter.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require('quarto').setup {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "all",
        languages = { "r", "python", "julia", "bash", "html" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        -- NOTE: setup your own keymaps:
        hover = "K",
        definition = "grd",
        rename = "grn",
        references = "grr",
        format = "<leader>grf",
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",        -- "molten", "slime", "iron" or <function>
        ft_runners = { python = 'molten' }, -- filetype to runner, ie. `{ python = "molten" }`.
        -- Takes precedence over `default_method`
        never_run = { 'yaml' },           -- filetypes which are never sent to a code runner
      },
    }
  end

}
