---@diagnostic disable: no-unknown
return { -- Autocompletion
  enabled = false,
  lazy = false,
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },

    'saadparwaiz1/cmp_luasnip',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    -- Add cmp for buffer and path
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'lukas-reineke/cmp-under-comparator',
    'onsails/lspkind.nvim',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'plug.nvim-cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    local border_opts = {
      border = 'rounded',
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
    }
    vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
    end


    --- HACK-: Override `vim.lsp.util.stylize_markdown` to use Treesitter.
    ---@param bufnr integer
    ---@param contents string[]
    ---@param opts table
    ---@return string[]
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
      contents = vim.lsp.util._normalize_markdown(contents, {
        width = vim.lsp.util._make_floating_popup_size(contents, opts),
      })
      vim.bo[bufnr].filetype = 'markdown'
      vim.treesitter.start(bufnr)
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

      return contents
    end









    -- local defaults = require("cmp.config.default")()
    cmp.setup {
      performance = {
        max_view_entries = 7,
      },
      snippet = {
        -- expand = function(args)
        --   luasnip.lsp_expand(args.body)
        -- end,
        expand = function(args)
          vim.snippet.expand(args.body)
        end
      },
      completion = { completeopt = 'menu,menuone,noinsert,noselect' },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
        hover = cmp.config.window.bordered(),
      },
      formatting = {
        format = require('lspkind').cmp_format {
          mode = 'symbol',       -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          with_text = true,
          maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          -- menu = {
          --   codeium = '[AI]',
          --   buffer = '[BUF]',
          --   nvim_lsp = '[LSP]',
          --   nvim_lsp_signature_help = '[LSP]',
          --   nvim_lsp_document_symbol = '[LSP]',
          --   nvim_lua = '[API]',
          --   path = '[PATH]',
          --   luasnip = '[SNIP]',
          -- },
        },
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's', 'c' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's', 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's', 'c' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's', 'c' }),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        -- ['<Tab>'] = cmp.mapping.confirm { select = true },
        -- ['<C-Space>'] = cmp.mapping.confirm { select = true },
        ['<Esc>'] = cmp.mapping.close(),
        ['<C-e>'] = cmp.mapping.close(),

        -- ['<C-j>'] = cmp.mapping.confirm { select = true },
        ['<CR>'] = cmp.mapping.confirm { select = true },
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     -- cmp.select_next_item()
        --     cmp.confirm { select = true }
        --     -- if luasnip.expand_or_locally_jumpable(1) then
        --     --   luasnip.jump(1)
        --   elseif vim.snippet.active({ direction = 1 }) then
        --     vim.snippet.jump(1)
        --   else
        --     require('neotab').tabout()
        --   end
        -- end, { "i", "s" }),
        -- ['<S-Tab>'] = cmp.mapping(function()
        --   if vim.snippet.active({ direction = -1 }) then
        --     vim.snippet.jump(-1)
        --     -- if luasnip.expand_or_locally_jumpable(-1) then
        --     --   luasnip.jump(-1)
        --   end
        -- end, { 'i', 's' }),
        ['<C-l>'] = cmp.mapping(function()
          if vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
            -- if luasnip.expand_or_locally_jumpable() then
            --   luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
            -- if luasnip.locally_jumpable(-1) then
            --   luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'buffer',                 max_item_count = 5 },
        { name = 'path',                   max_item_count = 5 },
        { name = 'luasnip' },
      },
    }
    cmp.setup.cmdline(':', {
      -- mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
          { name = 'cmdline' },
        }),
      mapping = cmp.mapping.preset.cmdline {
        -- ['<C-Space>'] = cmp.mapping(function()cmp.confirm { select = true } vim.api.nvim_input ' 'end, { 'c' }),
        ['<C-Tab>'] = cmp.mapping(function()
          cmp.confirm { select = true }
          vim.api.nvim_input ' '
        end, { 'c' }),
        ['<Tab>'] = cmp.mapping(function()
          cmp.confirm { select = true }
        end, { 'c' }),
        ['<C-CR>'] = cmp.mapping(function()
          cmp.confirm { select = true }
          vim.api.nvim_input '<CR>'
        end, { 'c' }),
        ['<C-y>'] = cmp.mapping(function()
          cmp.confirm { select = true }
        end, { 'c' }),
      },
    })
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
      },
    })
  end,
}

