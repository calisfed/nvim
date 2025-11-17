return {

  "OXY2DEV/markview.nvim",
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
    -- note: under dependencies are for lazy loading
    '3rd/image.nvim',
    'jbyuki/nabla.nvim',
    'jghauser/follow-md-links.nvim',
  },
  enabled = false,
  lazy = true, -- Recommended
  -- ft = "markdown", -- If you decide to lazy-load anyway
  ft = { "markdown", "typst" },
  opts = function()
    local presets = require('markview.presets')
    require('markview').setup({
      preview = {
        enable = true,
        enable_hybrid_mode = true,
        map_gx = true,

        debounce = 150,
        icon_provider = "internal",

        filetypes = { "markdown", "quarto", "rmd", "typst" },
        ignore_buftypes = { "nofile" },
        raw_previews = {},

        modes = { "n", "no", "c" },
        hybrid_modes = { "n", "i" },

        linewise_hybrid_mode = true,
        max_buf_lines = 1000,

        draw_range = { 2 * vim.o.lines, 2 * vim.o.lines },
        edit_range = { 0, 0 },

        splitview_winopts = {
          split = "right"
        },
      },
      markdown = {
        headings = presets.headings.glow,                 -- glow | glow_center | slanted | arrowed | simple | marker
        horizontal_rules = presets.horizontal_rules.thin, -- thin | thick | solid | double | dashed | dotted | arrowed
        tables = presets.tables.rounded,                  -- none | single | double | rounded | solid
      },
      list_items = {
        enable = false,
        indent_size = 0,
      }
    })
    require("markview.extras.headings").setup() -- Command :Headings increase|decrease
    require("markview.extras.editor").setup()   -- Command :Editor create|edit
    -- Command :Checkboxes toggle|change|interactive
    -- require("markview.extras.checkboxes").setup({
    -- 	--- Default checkbox state(used when adding checkboxes).
    -- 	---@type string
    -- 	default = "X",

    -- 	--- Changes how checkboxes are removed.
    -- 	---@type
    -- 	---| "disable" Disables the checkbox.
    -- 	---| "checkbox" Removes the checkbox.
    -- 	---| "list_item" Removes the list item markers too.
    -- 	remove_style = "disable",

    -- 	--- Various checkbox states.
    -- 	---
    -- 	--- States are in sets to quickly change between them
    -- 	--- when there are a lot of states.
    -- 	---@type string[][]
    -- 	states = { { " ", "/", "X" }, { "<", ">" }, { "?", "!", "*" }, { '"' }, { "l", "b", "i" }, { "S", "I" }, { "p", "c" }, { "f", "k", "w" }, { "u", "d" } }
    -- })
    -- vim.keymap.set("n", "<leader>x", "<cmd>Checkbox<cr>", {desc = "Change checkboxes state"})
  end
}
