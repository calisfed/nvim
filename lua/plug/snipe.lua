return {
  "leath-dub/snipe.nvim",
  enabled = false,
  lazy = false,
  branch = "snipe2",
  --   keys = {
  --     { "<leader><leader>", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" }
  --   },
  opts = function()
    local config = {
      ui = {
        max_height = -1, -- -1 means dynamic height
        -- Where to place the ui window
        -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
        ---@type "topleft"|"bottomleft"|"topright"|"bottomright"|"center"|"cursor"
        position = "center",
        -- Override options passed to `nvim_open_win`
        -- Be careful with this as snipe will not validate
        -- anything you override here. See `:h nvim_open_win`
        -- for config options
        open_win_override = {
          -- title = "My Window Title",
          border = "single", -- use "rounded" for rounded border
        },

        -- Preselect the currently open buffer
        preselect_current = true,
      },
      hints = {
        -- Charaters to use for hints (NOTE_: make sure they don't collide with the navigation keymaps)
        -- dictionary = "sadflewcmpghio",
        dictionary = "123qweasdzxc",
      },
      navigate = {
        next_page = "J",
        prev_page = "K",
        under_cursor = "<cr>",
        cancel_snipe = "<esc>",
        close_buffer = "D",
        open_vsplit = "v",
        open_split = "H",
      },
      sort = "default"
    }

    local function openBufferMenu()
      local snipe = require("snipe")
      local cmd = snipe.config.sort == "last" and "ls t" or "ls"
      local buf = require("snipe.buffer").get_buffers(cmd)
      snipe.ui_select_menu = require("snipe.menu"):new { position = "center", dictionary = "1234qwerasdfzxc", open_win_override = { border = "single" } }
      snipe.ui_select_menu:add_new_buffer_callback(snipe.default_keymaps)
      snipe.ui_select_menu:add_new_buffer_callback(function(m) vim.keymap.set("n", "<esc>", function() m:close() end, { nowait = true, buffer = m.buf }) end)
      snipe.ui_select_menu:add_new_buffer_callback(function(m)
        vim.keymap.set("n", "v",
          function()
            local bufnr = m.items[m:hovered()].id
            m:close()
            vim.api.nvim_open_win(bufnr, true, { vertical = true, win = 0 })
          end, { nowait = true, buffer = m.buf })
      end)
      snipe.ui_select_menu.config.open_win_override.title = 'Buffers'
      snipe.ui_select(buf, { format_item = function(b) return " " .. b.name .. "  " end }, function(b)
        snipe.ui_select_menu:close(); vim.api.nvim_set_current_buf(b.id)
      end)
    end
    vim.keymap.set("n", "<leader><leader>", function() openBufferMenu() end, { desc = "Quick select buffer" })
    -- printf

    return config
  end,
}
