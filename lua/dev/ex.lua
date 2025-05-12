
-- _G.ll = {
--   0, 'folke/tokyonight.nvim',
--   0, 'sainnhe/sonokai',
--   0, 'rose-pine/neovim',
--   'EdenEast/nightfox.nvim',
--   0, "diegoulloao/neofusion.nvim",
--   0, "0xstepit/flow.nvim",
--   'lambdalisue/suda.vim', -- Edit with sudo permissions automatically
--   'stevearc/oil.nvim',    -- File explorer
--   'nvim-tree/nvim-web-devicons',
--   { source = 'jiaoshijie/undotree', depends = { 'nvim-lua/plenary.nvim' } },
--   { source = 'ibhagwan/fzf-lua',    depends = { 'nvim-tree/nvim-web-devicons' } },
--   'tpope/vim-sleuth',        -- Auto detect tabstop/shiftwidth
--   'lewis6991/gitsigns.nvim', -- Add git related signs
--   { source = 'ThePrimeagen/harpoon',  depends = { 'nvim-lua/plenary.nvim' },     checkout = 'harpoon2' },
--   { source = 'kevinhwang91/nvim-ufo', depends = { 'kevinhwang91/promise-async' } },
--   "max397574/better-escape.nvim",
--   "nvim-lua/plenary.nvim",
--   "folke/which-key.nvim",
--   "tridactyl/vim-tridactyl",
--   { source = 'hrsh7th/nvim-cmp',      depends = { 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'rafamadriz/friendly-snippets', 'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'lukas-reineke/cmp-under-comparator', } },
--   'onsails/lspkind.nvim',
--   'tamton-aquib/duck.nvim',
--   { source = 'OXY2DEV/helpview.nvim', depends = { 'nvim-treesitter/nvim-treesitter' }, },
--   'leath-dub/snipe.nvim',
-- }
-- _G.lz = {
--   color = {
--   'folke/tokyonight.nvim',
--   'sainnhe/sonokai',
--   'rose-pine/neovim',
--   'EdenEast/nightfox.nvim',
--   "diegoulloao/neofusion.nvim",
--   "0xstepit/flow.nvim",
--   },
--   'stevearc/oil.nvim',    -- File explorer
--   { source = 'ThePrimeagen/harpoon',  depends = { 'nvim-lua/plenary.nvim' }, checkout = 'harpoon2' },
-- }
--
-- ---@param plugin_list table
-- ---@param asap? boolean default true
-- ---@param location? string default "plugins"
-- _G.load_list = function(plugin_list, asap, location)
--   now = now or true
--   location = location or "plugins"
--   local disable = 0
--   for _, plugin in ipairs(plugin_list) do
--     -- Check if disable the next plugin
--     if plugin == 0 then
--       disable = 1
--       goto continue
--     end
--
--     -- Adding the plugin in to the list
--     MiniDeps.add(plugin)
--
--     -- Skip the setup if disable
--     if disable == 1 then
--       disable = 0
--       goto continue
--     end
--     -- Setup using MiniDeps.now or MiniDeps.later
--     local name = plugin
--     if type(plugin) == "table" then
--       name = plugin.source
--     end
--     name = location .. '.' .. name:gsub('.*/', ""):gsub("[%.%-]n?vim$", ""):gsub("n?vim%-", "")
--     print(name)
--
--
--     -- IDEA: If there is plugin file, then load it, if not then just run setup unlest stated other wise
--
--     -- if now == true then
--     --   now(pcall(require, name))
--     -- else
--     --   later(pcall(require, name))
--     -- end
--
--     ::continue::
--   end
-- end



_G.lz = {
  color = {
  'folke/tokyonight.nvim',
  'sainnhe/sonokai',
  'rose-pine/neovim',
  'EdenEast/nightfox.nvim',
  "diegoulloao/neofusion.nvim",
  "0xstepit/flow.nvim",
  },
  'stevearc/oil.nvim',    -- File explorer
  { source = 'ThePrimeagen/harpoon',  depends = { 'nvim-lua/plenary.nvim' }, checkout = 'harpoon2' },
}

for i,v in pairs(lz) do
  print(i)
  print(v)
end

---@param plugin_list table
---@param asap? boolean default true
---@param location? string default "plugins"
_G.zl = function(plugin_list, asap, location)
  local now = asap or true
  location = location or "plugins"

  for k, plugin in pairs(plugin_list) do
    -- Add 
    if type(k) ~= 'number' then
      for _, p in pairs(plugin) do
        -- add(p)
        print('packed')
        print(p)
      end
    else
      print('free')
      local name = plugin
      if type(plugin) == "table" then
        name = plugin.source
      end
      print(name)
    end

    -- name = location .. '.' .. name:gsub('.*/', ""):gsub("[%.%-]n?vim$", ""):gsub("n?vim%-", "")
  end
end

-- config
--      |- color
--      |- cmp
--      |- lsp
--      |- plug1
--      |- 
