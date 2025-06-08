return {
  'saghen/blink.cmp',
  lazy = false,
  -- dependencies = 'rafamadriz/friendly-snippets',

  dependencies = {
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  },
  version = '*',
  -- build = 'cargo build --release',
  -- build = 'nix run .#build-plugin',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config

  opts = function()
    return {
      keymap = {
        -- preset = 'super-tab'
        ['<C-j>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<Esc>'] = { 'hide', 'fallback' },

        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          function()
            require('neotab').tabout()
          end,
          'snippet_forward',
          'fallback'
        },

        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-l>'] = { 'snippet_forward' },
        ['<C-h>'] = { 'snippet_backward' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      completion = {
        keyword = { range = 'full' },
        menu = {
          -- border = 'single',
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          window = { border = 'single' }
        },
      },
      signature = {
        enabled = true,
        window = { border = 'single' }
      },
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },

      snippets = { preset = 'luasnip' },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        -- default = { 'lsp', 'path', 'snippets', 'buffer' },
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          if vim.bo.filetype == 'lua' then
            return { 'lsp', 'buffer', 'path'  }
          elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            return { 'buffer' }
          else
            return { 'lsp', 'path', 'snippets', 'buffer' }
          end
        end,
        providers = { },
      }}
  end

}
