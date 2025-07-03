return {
  enabled = false,
  'SunnyTamang/select-undo.nvim',
  opts = function()
    local config = {
      persistent_undo = true, -- Enables persistent undo history
      mapping = true,      -- Enables default keybindings
      line_mapping = "guu", -- Undo for entire lines
      partial_mapping = "gcu" -- Undo for selected characters -- Note: dont use this line as gu can also handle partial undo
    }
    return config
  end
}
