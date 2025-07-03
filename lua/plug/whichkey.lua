return
{
  enabled = false,
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup({
      preset = 'helix',
      spec   = {
        { "<leader>s",  group = "Search" },
        { "<leader>t",  group = "Toggle" },
        -- { "<leader>b", group = "Buffer" },
        { "<leader>c",  group = "Code" },
        { "<leader>sC", group = "Color" },
        { "<leader>sW", group = "Words" },
        { "<leader>V",  group = "VNese" },
        { "<leader>g",  group = "Git/Go" },
        { "<leader>n",  group = "Notes" },
        -- { "<leader>S", group = "Session" },
        -- { "<leader>u", group = "Undotree" },
      },
      win    = {
        border = 'single',
      }
    })
    -- require('which-key').add({
    --   { "<leader>s", group = "Search" },
    --   { "<leader>t", group = "Toggle" },
    --   -- { "<leader>b", group = "Buffer" },
    --   { "<leader>c", group = "Code" },
    --   { "<leader>C", group = "Color" },
    --   { "<leader>V", group = "VNese" },
    --   { "<leader>g", group = "Git/Go" },
    --   { "<leader>n", group = "Notes" },
    --   -- { "<leader>S", group = "Session" },
    --   -- { "<leader>u", group = "Undotree" },
    -- })
  end,
}
