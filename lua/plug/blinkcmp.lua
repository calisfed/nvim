return {

  enabled = false,
  'saghen/blink.cmp',
  lazy = false,
  -- dependencies =

  dependencies = {
    -- { 'L3MON4D3/LuaSnip', version = 'v2.*', },
    'rafamadriz/friendly-snippets',
    "erooke/blink-cmp-latex",
  },
  version = '*',
  -- build = 'cargo build --release',
  -- build = 'nix run .#build-plugin',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config

  opts = function()
    -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
    require('blink.cmp').setup({
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
          'snippet_forward',
          function()
            require('neotab').tabout()
          end,
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
      appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'mono' },
      completion = {
        keyword = { range = 'prefix' }, -- 'prefix' or 'full'
        trigger = {
          show_on_accept_on_trigger_character = false,
          show_on_backspace_in_keyword = true,
          show_on_trigger_character = true,
        },
        list = {
          max_items = 50, -- default 200
          selection = { auto_insert = true, },
        },
        menu = {
          border = 'single',
          draw = {
            treesitter = { "lsp" },
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
            components = {
              kind_icon = {
                text = function(ctx)
                  if ctx.source_id == 'cmdline' then return end
                  return ctx.kind_icon .. ctx.icon_gap
                end,
              },
              source_name = {
                text = function(ctx)
                  if ctx.source_id == 'cmdline' then return end
                  return ctx.source_name:sub(1, 4)
                end,
              },
            },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 100, window = { border = 'single' } },
        ghost_text = { enabled = false, },
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
        completion = { menu = {auto_show = true} },
      },

      snippets = {
        -- preset = 'luasnip'
        preset = 'default'
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            return { 'buffer' }
          else
            return { 'lsp', 'path', 'snippets', 'buffer' }
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
          -- snippets = {
          --   should_show_items = function (ctx)
          --     return ctx.trigger.initial_kind ~= 'trigger_character'
          --   end
          -- },


        },
      }
    })
  end
}
