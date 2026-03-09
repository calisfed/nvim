return {
  enabled = false,
  'tigion/nvim-asciidoc-preview',
  ft = { 'asciidoc' },
  build = 'cd server && npm install --omit=dev --no-save',
  keys = {
    { "<leader>na", "<cmd>AsciiDocPreview<cr>", desc = "Preview Asciidoc" },
  },
  opts = {

    server = {
      -- Specifies how the AsciiDoc file is converted to HTML for the preview.
      -- `js`  - asciidoctor.js (no local installation needed)
      -- `cmd` - asciidoctor command (local installation needed)
      converter = 'asciidoctor',

      -- Specifies the hostname or IP address of the preview website for the client.
      -- This is only needed if you run neovim in a remote session and
      -- want to access the preview website from another machine.
      hostname = 'localhost',

      -- Specifies the port of the preview website on the client and server side.
      -- Must be between 10000 and 65535.
      port = 11235,
    },
    preview = {
      -- Specifies the scroll position of the preview website.
      -- `current` - Keep current scroll position
      -- `start`   - Start of the website
      -- `sync`    - (experimental) Same (similar) position as in Neovim
      --             => inaccurate, because very content dependent
      position = 'current',
    },
  }
}
