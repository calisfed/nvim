return {
  -- Fun to have, feel better than indent-blankline or mini.indent
  enabled = false,
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local config = {
      chunk = {
        enable = true,
        -- style = { {
        --   fg = "LightGreen",
        -- }
        -- },
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "─", --">",
        },
        duration = 0,
        delay = 0,
      },
      line_num = {
        enable = false,
        use_treesitter = true,
        style = { {
          fg = "LightGreen",
          bg = "#5f3f11",
        } }
      },
      indent = {
        enable = false,
      },
      blank = {
        enable = false,
        char = { "." },
      },
    }
    vim.cmd("hi HLChunk1 guifg=LightGreen gui=bold ")
    vim.cmd("hi HLChunk2 guifg=Red gui=bold ")
    return config
  end
}
