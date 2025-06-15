return {

  enabled = false,
  'saghen/blink.cmp',
  lazy = false,
  -- dependencies = 'rafamadriz/friendly-snippets',

  dependencies = {
    { 'L3MON4D3/LuaSnip', version = 'v2.*', },
    "erooke/blink-cmp-latex",
  },
  version = '*',
  -- build = 'cargo build --release',
  -- build = 'nix run .#build-plugin',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config

  opts = function()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
    require('blink.cmp').setup(
      {
        keymap = {
          -- preset = 'super-tab'
          -- ['<C-j>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-e>'] = { 'hide', 'show', 'fallback' },
          -- ['<Esc>'] = { 'hide', 'fallback' },

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
            auto_show = true,
            auto_show_delay_ms = 100,
            window = { border = 'single' }
          },
        },
        signature = {
          enabled = true,
          -- show_documentation = true,
          window = {
            border = 'single',
            show_documentation = true,
            direction_priority = { 's' }, -- {'s'} | {'n'}
          },
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
              return { 'lsp', 'buffer', 'path', 'snippets' }
            elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
              return { 'buffer' }
            elseif vim.bo.filetype == 'vim' and vim.bo.buftype == 'nofile' then
              return { 'ccb', 'path', 'buffer', 'lsp' }
            else
              return { 'lsp', 'path', 'snippets', 'buffer', 'latex' }
            end
          end,
          providers = {
            latex = {
              name = "Latex",
              module = "blink-cmp-latex",
              opts = {
                -- set to true to insert the latex command instead of the symbol
                insert_command = function(ctx)
                  local ft = vim.api.nvim_get_option_value("filetype", {
                    scope = "local",
                    buf = ctx.bufnr,
                  })
                  if ft == "tex" then
                    return true
                  end
                  return false
                end
              },
            },
            snippets = {
              opts = {
                search_paths = {
                  "~/.config/nvim/snippets/"
                }
              }
            },
            ccb = {
              name = "ccb",
              module = "dev.ccb"
            }

          },
        }
      })

    -- local luasnip = require("luasnip")
  end

}
