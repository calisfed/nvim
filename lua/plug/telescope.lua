return {
  enabled = false,
  lazy = false,
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    { 'nvim-tree/nvim-web-devicons',                enabled = vim.g.have_nerd_font },
    { 'rafi/telescope-thesaurus.nvim',              enabled = false, },
    { 'nvim-telescope/telescope-file-browser.nvim', enabled = true, },
    { 'archie-judd/telescope-words.nvim',           enabled = true, },
    { 'nvim-telescope/telescope-media-files.nvim',  enabled = false, },
    { 'debugloop/telescope-undo.nvim',              enabled = true }
  },
  opts = function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function copy_all_results(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local results = {}

      for entry in picker.manager:iter() do
        table.insert(results, entry.value)
      end

      local content = table.concat(results, "\n")
      vim.fn.setreg("+", content) -- Copies to system clipboard
      vim.notify("Copied " .. #results .. " entries to clipboard", vim.log.levels.INFO)
    end

    local function toggle_all(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      for entry in picker.manager:iter() do
        picker._multi:toggle(entry)
      end
    end

    local select_one_or_multi = function(prompt_bufnr)
      local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
        require('telescope.actions').close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then
            vim.cmd(string.format('%s %s', 'edit', j.path))
          end
        end
      else
        require('telescope.actions').select_default(prompt_bufnr)
      end
    end





    local image_preview = require 'personal.image_telescope'.telescope_image_preview()
    require('telescope').setup {
      defaults = require('telescope.themes').get_ivy({
        file_previewer = image_preview.file_previewer,
        buffer_previewer_maker = image_preview.buffer_previewer_maker,
        mappings = { i = {
          ['<c-enter>'] = 'to_fuzzy_refine',
          ["<esc>"] = actions.close,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-j>'] = actions.move_selection_next,
          ['<leader>Y'] = copy_all_results,
          ['<CR>'] = select_one_or_multi,
        }, },

        -- sorting_strategy = 'descending', -- default is 'descending'
        layout_config = {
          bottom_pane = { height = 0.4, preview_cutoff = 20, prompt_position = "top" },
          -- center = { height = 0.4, preview_cutoff = 40, prompt_position = "top", width = 0.5 },
          -- cursor = { height = 0.9, preview_cutoff = 40, width = 0.8 },
          -- horizontal = { height = 0.9, preview_cutoff = 120, prompt_position = "bottom", width = 0.8 },
          -- vertical = { height = 0.9, preview_cutoff = 40, prompt_position = "bottom", width = 0.8 }
        },
        preview = {
          mime_hook = function(filepath, bufnr, opts)
            local image = require("image")
            local preview_id = "telescope_image_preview"

            -- Clear previous image
            image.clear(preview_id)

            -- Check if it's an image
            local is_image = function(path)
              return path:match("%.png$") or path:match("%.jpg$") or path:match("%.jpeg$") or path:match("%.webp$")
            end

            if is_image(filepath) then
              local img = image.from_file(filepath, {
                id = preview_id,
                buffer = bufnr,
                window = opts.winid,
                x = 10, -- top-left corner
                y = 10,
                -- width = math.floor(vim.api.nvim_win_get_width(opts.winid) * 0.5),
                -- height = math.floor(vim.api.nvim_win_get_height(opts.winid) * 0.5),
                inline = false,
                with_virtual_padding = true,
              })
              -- vim.defer_fn(function()
              --   img:render()
              -- end, 0)
              img:render()
            else
              require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Not an image file")
            end
          end,
        },

      }),



      pickers = {
        find_files = {
          -- sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
          find_command = { "fd" },
          follow = false,
          hidden = false,
        },
      },
      extensions = {
        ['ui-select'] = {},
        thesaurus = { provider = 'freedictionaryapi' },
        file_browser = {
          mappings = {
            ["i"] = {
              ["<C-o>"] = function(prompt_bufnr)
                vim.cmd('edit ' .. prompt_bufnr)
              end
            }
          },
          hijack_netrw = true,
        },
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          -- find command (defaults to `fd`)
          find_cmd = "rg"
        },
        undo = {
          -- layout_strategy = "vertical",
          -- layout_config = {
          --   preview_height = 0.8,
          -- },
          saved_only = true,
          mappings = {
            i = {
              ["<cr>"] = require("telescope-undo.actions").yank_additions,
              ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
              ["<C-cr>"] = require("telescope-undo.actions").restore,
              -- alternative defaults, for users whose terminals do questionable things with modified <cr>
              ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
              ["<C-r>"] = require("telescope-undo.actions").restore,
            },
            n = {
              ["y"] = require("telescope-undo.actions").yank_additions,
              ["Y"] = require("telescope-undo.actions").yank_deletions,
              ["u"] = require("telescope-undo.actions").restore,
            },
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'media_files')
    pcall(require('telescope').load_extension, 'undo')


    local function from_git_root()
      local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        return vim.v.shell_error == 0
      end

      local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git_path, ":h")
      end

      local opts = {}
      if is_git_repo() then
        opts = {
          cwd = get_git_root(),
          sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
        }
      end
      return opts
    end

    vim.keymap.set('n', '<leader>sh', function() require('telescope.builtin').help_tags() end, { desc = 'Search helps' })
    vim.keymap.set('n', '<leader>sk', function() require('telescope.builtin').keymaps() end, { desc = 'Search keymaps' })
    vim.keymap.set('n', '<leader>sf', function() require('telescope.builtin').find_files(from_git_root()) end, { desc = 'Search files' })
    vim.keymap.set('n', '<leader>sF', function() require('telescope').extensions.file_browser.file_browser() end, { desc = 'Search files' })
    -- vim.keymap.set('n', '<leader>ss', functionrequire('telescope.builtin').git_files() end, { desc = 'Search Git file' })
    vim.keymap.set('n', '<leader>sw', function() require('telescope.builtin').grep_string() end, { desc = 'Search current word' })
    vim.keymap.set('n', '<leader>sg', function() require('telescope.builtin').live_grep() end, { desc = 'Search live grep' })
    vim.keymap.set('n', '<leader>sd', function() require('telescope.builtin').diagnostics() end, { desc = 'Search diagnostics' })
    vim.keymap.set('n', '<leader>sb', function() require('telescope.builtin').buffers() end, { desc = 'Search buffers' })
    ---@diagnostic disable-next-line: undefined-global
    vim.keymap.set('n', '<leader>sm', function() require('telescope.builtin').man_pages({ sections = ALL }) end, { desc = 'Search manunals' })
    vim.keymap.set('n', '<leader>sr', function() require('telescope.builtin').registers() end, { desc = 'Search registers' })
    vim.keymap.set('n', '<leader>sl', function() require('telescope.builtin').loclist() end, { desc = 'Search location list' })
    vim.keymap.set('n', '<leader>sj', function() require('telescope.builtin').jumplist() end, { desc = 'Search jump list' })
    vim.keymap.set('n', '<leader>st', function() require('telescope.builtin').treesitter() end, { desc = 'Search treesitter' })
    vim.keymap.set('n', '<leader>s.', function() require('telescope.builtin').resume() end, { desc = 'Search resume' })
    -- vim.keymap.set('n', '<leader>sT', function() require('telescope').extensions.thesaurus.lookup() end, { desc = 'Search thesaurus' })
    vim.keymap.set('n', '<leader>sWd', function() require('telescope').extensions.telescope_words.search_dictionary_for_word_under_cursor() end, { desc = 'Search dictionary' })
    vim.keymap.set('n', '<leader>sWt', function() require('telescope').extensions.telescope_words.search_thesaurus_for_word_under_cursor() end, { desc = 'Search thesaurus' })
    vim.keymap.set('n', '<leader>su', function() require('telescope').extensions.undo.undo() end, { desc = 'Search thesaurus' })
    -- vim.keymap.set('n', '<leader>si', function () require('telescope').extensions.media_files.media_files() end, {desc = 'Search image'})
    vim.keymap.set('n', '<leader>ss', function() require('telescope.builtin').builtin({ include_extensions = true }) end, { desc = 'Search Telescope' })

    -- See `:help telescope.builtin`
    -- local ut = require('personal.utils')
    -- local CallTelescope = function(input, opts)
    --   opts = opts or {}
    --   opts.layout_config = opts.layout_config or { height = 0.30 }
    --   opts.previewer = opts.previewer or true
    --   -- local theme = opts.theme or require('telescope.themes').get_dropdown(opts)
    --   local theme = opts.theme or require('telescope.themes').get_ivy(opts)
    --   -- local theme = opts.theme or require('telescope.themes').get_cursor(opts)
    --   input(theme)
    --   -- input(opts)
    -- end

    -- vim.keymap.set('n', '<leader>sh', function() CallTelescope(require('telescope.builtin').help_tags, {}) end, { desc = 'Search helps' })
    -- vim.keymap.set('n', '<leader>sk', function() CallTelescope(require('telescope.builtin').keymaps, {}) end, { desc = 'Search keymaps' })
    -- vim.keymap.set('n', '<leader>sf', function() CallTelescope(require('telescope.builtin').find_files, from_git_root()) end, { desc = 'Search files' })
    -- vim.keymap.set('n', '<leader>sF', function() CallTelescope(require('telescope').extensions.file_browser.file_browser, {}) end, { desc = 'Search files' })
    -- -- vim.keymap.set('n', '<leader>ss', function() CallTelescope(require('telescope.builtin').git_files, {}) end, { desc = 'Search Git file' })
    -- vim.keymap.set('n', '<leader>sw', function() CallTelescope(require('telescope.builtin').grep_string, {}) end, { desc = 'Search current word' })
    -- vim.keymap.set('n', '<leader>sg', function() CallTelescope(require('telescope.builtin').live_grep, {}) end, { desc = 'Search live grep' })
    -- vim.keymap.set('n', '<leader>sd', function() CallTelescope(require('telescope.builtin').diagnostics, {}) end, { desc = 'Search diagnostics' })
    -- vim.keymap.set('n', '<leader>sb', function() CallTelescope(require('telescope.builtin').buffers, {}) end, { desc = 'Search buffers' })
    -- ---@diagnostic disable-next-line: undefined-global
    -- vim.keymap.set('n', '<leader>sm', function() CallTelescope(require('telescope.builtin').man_pages, { sections = ALL }) end, { desc = 'Search manunals' })
    -- vim.keymap.set('n', '<leader>sr', function() CallTelescope(require('telescope.builtin').registers, {}) end, { desc = 'Search registers' })
    -- vim.keymap.set('n', '<leader>sl', function() CallTelescope(require('telescope.builtin').loclist, {}) end, { desc = 'Search location list' })
    -- vim.keymap.set('n', '<leader>sj', function() CallTelescope(require('telescope.builtin').jumplist, {}) end, { desc = 'Search jump list' })
    -- vim.keymap.set('n', '<leader>st', function() CallTelescope(require('telescope.builtin').treesitter, {}) end, { desc = 'Search treesitter' })
    -- vim.keymap.set('n', '<leader>s.', function() CallTelescope(require('telescope.builtin').resume, {}) end, { desc = 'Search resume' })
    -- -- vim.keymap.set('n', '<leader>sT', function() require('telescope').extensions.thesaurus.lookup() end, { desc = 'Search thesaurus' })
    -- vim.keymap.set('n', '<leader>sWd', function() require('telescope').extensions.telescope_words.search_dictionary_for_word_under_cursor() end, { desc = 'Search dictionary' })
    -- vim.keymap.set('n', '<leader>sWt', function() require('telescope').extensions.telescope_words.search_thesaurus_for_word_under_cursor() end, { desc = 'Search thesaurus' })
    -- vim.keymap.set('n', '<leader>ss', function() CallTelescope(require('telescope.builtin').builtin, { include_extensions = true }) end, { desc = 'Search Telescope' })
  end,

}
