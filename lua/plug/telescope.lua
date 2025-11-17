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





    -- local image_preview = require 'personal.image_telescope'.telescope_image_preview()

    require('telescope').setup {
      defaults = require('telescope.themes').get_ivy({
        -- file_previewer = image_preview.file_previewer,
        -- buffer_previewer_maker = image_preview.buffer_previewer_maker,
        mappings = { i = {
          ['<A-p>'] = require('telescope.actions.layout').toggle_preview,
          ['<c-enter>'] = 'to_fuzzy_refine',
          ['<esc>'] = actions.close,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-j>'] = actions.move_selection_next,
          ['<leader>Y'] = copy_all_results,
          ['<CR>'] = select_one_or_multi,
        }, },

        -- sorting_strategy = 'ascending', -- default is 'descending'
        layout_config = {
          bottom_pane = { height = 0.4, preview_cutoff = 20, prompt_position = "top" },
          -- center = { height = 0.4, preview_cutoff = 40, prompt_position = "top", width = 0.5 },
          -- cursor = { height = 0.9, preview_cutoff = 40, width = 0.8 },
          -- horizontal = { height = 0.9, preview_cutoff = 120, prompt_position = "bottom", width = 0.8 },
          -- vertical = { height = 0.9, preview_cutoff = 40, prompt_position = "bottom", width = 0.8 }
        },
        preview = {
          hide_on_startup = true,
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

    -- local Layout = require "telescope.pickers.layout"
    -- require("telescope").setup {
    --   defaults = {
    --     create_layout = function(picker)
    --       local function create_window(enter, win_opts)
    --         local bufnr = vim.api.nvim_create_buf(false, true)
    --         local winid = vim.api.nvim_open_win(bufnr, enter, win_opts)
    --         vim.wo[winid].winhighlight = "Normal:Normal"
    --         return Layout.Window {
    --           bufnr = bufnr,
    --           winid = winid,
    --         }
    --       end

    --       local ph = vim.api.nvim_win_get_height(0)
    --       local pw = vim.api.nvim_win_get_width(0)
    --       local percent = 0.4
    --       local w = math.floor(pw * 0.4)
    --       -- percentage of the mock ivy layout
    --       local h = math.floor(ph * 0.4)

    --       local function destory_window(window)
    --         if window then
    --           if vim.api.nvim_win_is_valid(window.winid) then
    --             vim.api.nvim_win_close(window.winid, true)
    --           end
    --           if vim.api.nvim_buf_is_valid(window.bufnr) then
    --             vim.api.nvim_buf_delete(window.bufnr, { force = true })
    --           end
    --         end
    --       end

    --       local layout = Layout {
    --         picker = picker,
    --         mount = function(self)
    --           -- relative = editor
    --           -- self.prompt  = create_window(true,{style = 'minimal', relative = 'editor', width = math.floor(pw / 2) - math.floor(pw * 0.2), height = 1, row = ph - h - 2, col = 0, title = '', title_pos = 'center', border = { "─", "─", "─", " ", "─", "─", "─", " " }, border = { "─", "─", "┬", "│", "┤", "─", "─", " " },})
    --           -- self.results = create_window(false,{style = 'minimal', relative = 'editor', width = w - math.floor(pw * 0.2), height = h - 3, row = ph, col = 0, anchor = 'SW', title = "cwd: " .. vim.fn.getcwd(0), title_pos = 'left', border = { " ", " ", "│", "│", " ", " ", " ", " " }})
    --           -- self.preview = create_window(false,{style = 'minimal', relative = 'editor', width = w + math.floor(pw * 0.2) - 2, height = h, row = ph, col = pw, anchor = 'SE', title = '', title_pos = 'center', border = { "┌", "─", "┐", " ", " ", " ", "│", "│" }})
    --           -- print(vim.inspect(picker))

    --           local tit = function()
    --             if picker.prompt_title == 'Find Files' then
    --               if picker.cwd then
    --                 return 'cwd: ' .. picker.cwd
    --               else
    --                 return vim.fn.getcwd(0)
    --               end
    --             else
    --               return ''
    --             end
    --           end
    --           -- relative = win
    --           self.results = create_window(false,
    --             {
    --               style = 'minimal',
    --               relative = 'win',
    --               width = w,
    --               height = 10,
    --               row = ph,
    --               col = 0,
    --               anchor = 'SW',
    --               title = tit(),
    --               border = { " ", " ", "│", "│", "│", " ", " ", " " }
    --             })
    --           self.preview = create_window(false,
    --             {
    --               style = 'minimal',
    --               relative = 'win',
    --               width = pw - w - 3,
    --               height = 13,
    --               row = ph,
    --               col = pw,
    --               anchor = 'SE',
    --               border = { "┌", "─", "─", " ", " ", " ", "│", "│" }
    --             })
    --           self.prompt = create_window(true,
    --             {
    --               style = 'minimal',
    --               relative = 'win',
    --               width = w,
    --               height = 1,
    --               row = ph - 15,
    --               col = 0,
    --               title = picker
    --                   .prompt_title,
    --               border = { "─", "─", "┬", "│", "┤", "─", "─", " " },
    --             })
    --         end,
    --         unmount = function(self)
    --           destory_window(self.results)
    --           destory_window(self.preview)
    --           destory_window(self.prompt)
    --         end,
    --         update = function(self) end,
    --       }

    --       return layout
    --     end,

    --     sorting_strategy = 'ascending', -- default is 'descending'

    --     mappings = { i = {
    --       ['<c-enter>'] = 'to_fuzzy_refine',
    --       -- ["<esc>"] = actions.close,
    --       ['<C-k>'] = actions.move_selection_previous,
    --       ['<C-j>'] = actions.move_selection_next,
    --       ['<leader>Y'] = copy_all_results,
    --       ['<CR>'] = select_one_or_multi,
    --     }, },
    --     pickers = {
    --       find_files = {
    --         -- sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
    --         find_command = { "fd" },
    --         follow = false,
    --         hidden = false,
    --       },
    --     },
    --     extensions = {
    --       ['ui-select'] = {},
    --       thesaurus = { provider = 'freedictionaryapi' },
    --       file_browser = {
    --         mappings = {
    --           ["i"] = {
    --             ["<C-o>"] = function(prompt_bufnr)
    --               vim.cmd('edit ' .. prompt_bufnr)
    --             end
    --           }
    --         },
    --         hijack_netrw = true,
    --       },
    --       fzf = {
    --         fuzzy = true,                   -- false will only do exact matching
    --         override_generic_sorter = true, -- override the generic sorter
    --         override_file_sorter = true,    -- override the file sorter
    --         case_mode = "respect_case",     -- or "ignore_case" or "respect_case"
    --         -- the default case_mode is "smart_case"
    --       },
    --       media_files = {
    --         -- filetypes whitelist
    --         -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
    --         filetypes = { "png", "webp", "jpg", "jpeg" },
    --         -- find command (defaults to `fd`)
    --         find_cmd = "rg"
    --       },
    --       undo = {
    --         -- layout_strategy = "vertical",
    --         -- layout_config = {
    --         --   preview_height = 0.8,
    --         -- },
    --         saved_only = true,
    --         mappings = {
    --           i = {
    --             ["<cr>"] = require("telescope-undo.actions").yank_additions,
    --             ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
    --             ["<C-cr>"] = require("telescope-undo.actions").restore,
    --             -- alternative defaults, for users whose terminals do questionable things with modified <cr>
    --             ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
    --             ["<C-r>"] = require("telescope-undo.actions").restore,
    --           },
    --           n = {
    --             ["y"] = require("telescope-undo.actions").yank_additions,
    --             ["Y"] = require("telescope-undo.actions").yank_deletions,
    --             ["u"] = require("telescope-undo.actions").restore,
    --           },
    --         },
    --       },
    --     },
    --   }
    -- }

    -- require "telescope".setup({
    --   defaults = {
    --     mappings = {
    --       i = {
    --         ['<A-p>'] = require('telescope.actions.layout').toggle_preview
    --       },
    --       n = {
    --         ['<A-p>'] = require('telescope.actions.layout').toggle_preview
    --       }
    --     },
    --     preview = {
    --       hide_on_startup = true -- hide previewer when picker starts
    --     }
    --   }
    -- })




    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'media_files')
    pcall(require('telescope').load_extension, 'undo')
    pcall(require('telescope').load_extension, 'fzf')

    local ngram_highlighter = function(ngram_len, prompt, display)
      local highlights = {}
      display = display:lower()

      for disp_index = 1, #display do
        local char = display:sub(disp_index, disp_index + ngram_len - 1)
        if prompt:find(char, 1, true) then
          table.insert(highlights, {
            start = disp_index,
            finish = disp_index + ngram_len - 1,
          })
        end
      end

      return highlights
    end
    local Sorter = require('telescope.sorters').Sorter
    local get_rgfs = function(opts)
      opts = opts or {}

      local ngram_len = opts.ngram_len or 2

      local cached_ngrams = {}
      local function overlapping_ngrams(s, n)
        if cached_ngrams[s] and cached_ngrams[s][n] then
          return cached_ngrams[s][n]
        end

        local R = {}
        for i = 1, s:len() - n + 1 do
          R[#R + 1] = s:sub(i, i + n - 1)
        end

        if not cached_ngrams[s] then
          cached_ngrams[s] = {}
        end

        cached_ngrams[s][n] = R

        return R
      end

      return Sorter:new {
        -- self
        -- prompt (which is the text on the line)
        -- line (entry.ordinal)
        -- entry (the whole entry)
        scoring_function = function(_, prompt, line, _)
          if prompt == 0 or #prompt < ngram_len then
            return 1
          end

          local prompt_lower = prompt:lower()
          local line_lower = line:lower()

          local prompt_ngrams = overlapping_ngrams(prompt_lower, ngram_len)

          local N = #prompt

          local contains_string = line_lower:find(prompt_lower, 1, true)

          local consecutive_matches = 0
          local previous_match_index = 0
          local match_count = 0

          for i = 1, #prompt_ngrams do
            local match_start = line_lower:find(prompt_ngrams[i], 1, true)
            if match_start then
              match_count = match_count + 1
              if match_start > previous_match_index then
                consecutive_matches = consecutive_matches + 1
              end

              previous_match_index = match_start
            end
          end

          -- TODO: Copied from ashkan.
          local denominator = (
            (10 * match_count / #prompt_ngrams)
            -- biases for shorter strings
            -- TODO(ashkan): this can bias towards repeated finds of the same
            -- subpattern with overlapping_ngrams
            + 3 * match_count * ngram_len / #line
            + consecutive_matches
            + N / (contains_string or (2 * #line)) -- + 30/(c1 or 2*N)

          )

          if denominator == 0 or denominator ~= denominator then
            return -1
          end

          if #prompt > 2 and denominator < 0.5 then
            return -1
          end

          return 1 / denominator
        end,

        highlighter = opts.highlighter or function(_, prompt, display)
          return ngram_highlighter(ngram_len, prompt, display)
        end,
      }
    end

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

          -- sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
          -- sorter = require('telescope.sorters').get_fuzzy_file()
          -- sorter = get_rgfs(),
          -- tiebreak = function(current_entry, existing_entry, prompt)
          --   return false
          -- end
        }
      end
      return opts
    end

    vim.keymap.set('n', '<leader>sh', function() require('telescope.builtin').help_tags() end, { desc = 'Search helps' })
    vim.keymap.set('n', '<leader>sk', function() require('telescope.builtin').keymaps() end, { desc = 'Search keymaps' })
    vim.keymap.set('n', '<leader>sf', function() require('telescope.builtin').find_files(from_git_root()) end,
      { desc = 'Search files' })
    -- vim.keymap.set('n', '<leader>ss', functionrequire('telescope.builtin').git_files() end, { desc = 'Search Git file' })
    vim.keymap.set('n', '<leader>sw', function() require('telescope.builtin').grep_string() end,
      { desc = 'Search current word' })
    vim.keymap.set('n', '<leader>sg', function() require('telescope.builtin').live_grep() end,
      { desc = 'Search live grep' })
    vim.keymap.set('n', '<leader>sd', function() require('telescope.builtin').diagnostics() end,
      { desc = 'Search diagnostics' })
    vim.keymap.set('n', '<leader>sb', function() require('telescope.builtin').buffers() end, { desc = 'Search buffers' })
    ---@diagnostic disable-next-line: undefined-global
    vim.keymap.set('n', '<leader>sm', function() require('telescope.builtin').man_pages({sections = {"ALL"}}) end,
      { desc = 'Search manuals' })
    vim.keymap.set('n', '<leader>sr', function() require('telescope.builtin').registers() end,
      { desc = 'Search registers' })
    vim.keymap.set('n', '<leader>sl', function() require('telescope.builtin').loclist() end,
      { desc = 'Search location list' })
    vim.keymap.set('n', '<leader>sj', function() require('telescope.builtin').jumplist() end,
      { desc = 'Search jump list' })
    vim.keymap.set('n', '<leader>st', function() require('telescope.builtin').treesitter() end,
      { desc = 'Search treesitter' })
    vim.keymap.set('n', '<leader>s.', function() require('telescope.builtin').resume() end, { desc = 'Search resume' })
    -- vim.keymap.set('n', '<leader>sT', function() require('telescope').extensions.thesaurus.lookup() end, { desc = 'Search thesaurus' })
    vim.keymap.set('n', '<leader>sF', function() require('telescope').extensions.file_browser.file_browser() end,
      { desc = 'Search files browser' })
    vim.keymap.set('n', '<leader>sWd',
      function() require('telescope').extensions.telescope_words.search_dictionary_for_word_under_cursor() end,
      { desc = 'Search dictionary' })
    vim.keymap.set('n', '<leader>sWt',
      function() require('telescope').extensions.telescope_words.search_thesaurus_for_word_under_cursor() end,
      { desc = 'Search thesaurus' })
    vim.keymap.set('n', '<leader>su', function() require('telescope').extensions.undo.undo() end,
      { desc = 'Search thesaurus' })
    -- vim.keymap.set('n', '<leader>si', function () require('telescope').extensions.media_files.media_files() end, {desc = 'Search image'})
    vim.keymap.set('n', '<leader>sa', function() require('telescope.builtin').builtin({ include_extensions = true }) end,
      { desc = 'Search Telescope' })

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
