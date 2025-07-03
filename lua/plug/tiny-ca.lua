return {
  enabled = false,
  "rachartier/tiny-code-action.nvim", -- run and visualize code actions with Telescope
  event = "LspAttach",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  opts = function()
    local config = {}

    vim.keymap.set("n", "<leader>ca", function()
      require("tiny-code-action").code_action()
    end, { noremap = true, silent = true })
    return config
  end
}
