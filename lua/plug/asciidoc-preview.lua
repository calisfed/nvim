return {

  enabled = false,
  'tigion/nvim-asciidoc-preview',
  ft = { 'asciidoc' },
  keys = {
    { "<leader>na", "<cmd>AsciiDocPreview<cr>", desc = "Preview Asciidoc" },
  },
  -- build = 'cd server && npm install --omit=dev',
  opts = function()
    local config = {
      server = {
        -- converter = 'js', -- online, no need asciidoctor
        converter = 'cmd', -- local, need asciidoctor
        port = 11235,
      },
      preview = {
        ---@type 'current' | 'start' | 'sync'
        position = 'current',
      },
    }
    return config
  end
}
