return {
  enabled = false,
  'B00TK1D/neoghidra',
  config = function()
    require('neoghidra').setup({
      -- Path to your Ghidra installation
      ghidra_path = '/usr/bin/ghidra',  -- or set GHIDRA_INSTALL_DIR env var

      -- Auto-analyze binaries when opened
      auto_analyze = true,

      -- Default view: "decompiler" or "disassembly"
      default_view = "decompiler",

      -- Keymaps (customize as needed)
      -- keymaps = {
      --   toggle_view = "<leader>gt",
      --   goto_definition = "gd",
      --   rename_symbol = "<leader>gr",
      --   jump_to_offset = "<leader>go",
      --   list_functions = "<leader>gF",
      -- }
    })
  end
}
