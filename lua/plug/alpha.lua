return {
  'goolord/alpha-nvim',
  lazy = false,
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    local theta = require 'alpha.themes.theta'
    local dashboard = require("alpha.themes.dashboard")
    logo1 = [[
          ████ ██████           █████      ██
         ███████████             █████ 
         █████████ ███████████████████ ███   ███████████
        █████████  ███    █████████████ █████ ██████████████
       █████████ ██████████ █████████ █████ █████ ████ █████
     ███████████ ███    ███ █████████ █████ █████ ████ █████
    ██████  █████████████████████ ████ █████ █████ ████ ██████
      ]]
    theta.config.layout[2].val = vim.split(logo1, '\n')
    theta.config.layout[8] = theta.config.layout[4]
    theta.config.layout[7] = theta.config.layout[1]


    local function trim_path(path, num_components) -- Split the path into components using '/' as the delimiter
      local components = {}
      for component in path:gmatch("[^/]+") do
        table.insert(components, component)
      end -- Extract the last 'num_components'
      local start_index = math.max(#components - num_components + 1, 1)
      local trimmed_path = '/' .. table.concat(components, '/', start_index)
      return trimmed_path
    end
    local function shorten_path(path, max_length)
      if #path <= max_length then
        return path end
      local components = {}
      for component in path:gmatch("[^/]+") do
        table.insert(components, component) end
      -- Ensure we always keep the last two components (parent directory and file)
      local file_component = table.remove(components)
      local parent_component = table.remove(components)
      for i = 1, #components do components[i] = components[i]:sub(1, 1)
      end

      local shortened_path = '/' .. table.concat(components, "/") .. '/' .. parent_component .. '/' .. file_component

      if #shortened_path > max_length then -- In case even the shortened path is longer than max_length
        local tail = table.concat(components, "/", #components - 2)
        return "..." .. tail .. '/' .. parent_component .. '/' .. file_component
      end
      return shortened_path
    end
    local session_list = require 'auto-session.lib'.get_session_list(require 'auto-session'.get_root_dir())
    theta.config.layout[4] = {
      type     = "group",
      val      = {
        -- { type = "text",    val = "Sessions", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
      },
      position = 'center',
    }
    local count = 5;
    if (count > #session_list) then
      count = #session_list
    end
    -- for i = 1, count, 1 do
    --   theta.config.layout[4].val[i + 2] = dashboard.button(
    --     's' .. vim.fn.string(i),
    --     -- '󰝇  ' .. trim_path(session_list[i].session_name, 3),
    --     '󰝇  ' .. shorten_path(session_list[i].session_name, 35),
    --     "<cmd>lua require'auto-session'.RestoreSessionFile(\"" .. session_list[i].path .. "\")<cr>"
    --   )
    -- end


    theta.config.layout[6].val = {
      { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
      { type = "padding", val = 1 },
      dashboard.button('e', '  New file', '<cmd>ene<CR>'),
      dashboard.button('f', '  CWD', '<cmd>Telescope find_files<CR>'),
      dashboard.button('r', '󱑈  Recent files', ":Telescope oldfiles<cr>"),
      dashboard.button('c', '  Config', ":Telescope find_files cwd=~/.config/nvim<cr>"),
      dashboard.button('S', '  Sessions', "<cmd>SessionSearch<cr>"),
      dashboard.button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
      dashboard.button('q', '󰗼  Quit', '<cmd>qa<CR>'),
    }
    require('alpha').setup(theta.config)
  end









  --     config = function()
  --       local dashboard = require 'alpha.themes.dashboard'
  --       local logo1 = [[
  --                                              
  --       ████ ██████           █████      ██
  --      ███████████             █████ 
  --      █████████ ███████████████████ ███   ███████████
  --     █████████  ███    █████████████ █████ ██████████████
  --    █████████ ██████████ █████████ █████ █████ ████ █████
  --  ███████████ ███    ███ █████████ █████ █████ ████ █████
  -- ██████  █████████████████████ ████ █████ █████ ████ ██████
  -- ]]
  --
  --       local logo2 = [[
  -- ░▒▓███████▓▒░░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░
  -- ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
  -- ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
  -- ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
  -- ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
  -- ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
  -- ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░   ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
  --
  --       ]]
  --
  --       local logo = logo2
  --       dashboard.section.header.val = vim.split(logo, '\n')
  --
  --
  --
  --
  --       -- local session_list = require'auto-session.lib'.get_session_list(require'auto-session'.get_root_dir())
  --       -- for i = 1, 5,1 do
  --       --   local name = session_list[i]['session_name']
  --       --   local path = session_list[i]['path']
  --       --
  --       --   dashboard.section.buttons.val[i+1]= dashboard.button(i,name,"<cmd>source "..path.."<cr>")
  --       -- end
  --
  --       dashboard.section.buttons.val = {
  --         -- { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
  --         -- { type = 'padding', val = 1 },
  --
  --         dashboard.button('e', '  New file', '<cmd>ene<CR>'),
  --         dashboard.button('f', '  CWD', '<cmd>Telescope find_files<CR>'),
  --         -- dashboard.button('r', '󱑈  Recent files', ":FzfLua oldfiles<cr>"),
  --         dashboard.button('r', '󱑈  Recent files', ":Telescope oldfiles<cr>"),
  --         dashboard.button('c', '  Config', ":Telescope find_files cwd=~/.config/nvim<cr>"),
  --         -- ":FzfLua files cwd=~/.config/nvim<cr>"
  --
  --         dashboard.button('s', '  Sessions', "<cmd>SessionSearch<cr>"),
  --         -- dashboard.button('p', '  Projects', "<cmd>lua require'telescope'.extensions.project.project()<cr>"),
  --         dashboard.button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
  --         dashboard.button('q', '󰗼  Quit', '<cmd>qa<CR>'),
  --
  --       }
  --       dashboard.section.header.opts.hl = 'AlphaHeader'
  --       dashboard.opts.layout[1].val = 100
  --       require('alpha').setup(dashboard.opts)
  --     end,
}
