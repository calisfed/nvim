return {
	{ enabled = false, 'lambdalisue/suda.vim',         event = "BufEnter" },
	{ enabled = false, 'NStefan002/screenkey.nvim',    cmd = 'Screenkey',                                   opts = {}, },
	{ enabled = false, 'tpope/vim-sleuth',             event = "VeryLazy", },
	{ enabled = false, "ZWindL/orphans.nvim",          config = function() require('orphans').setup({}) end },
	{ enabled = false, 'HawkinsT/pathfinder.nvim',     lazy = false }, -- enhanced gf gF gx
	{ enabled = false, 'wildfunctions/myeyeshurt',     opts = {} },   -- resting eye after a while
	{ enabled = false, 'shrynx/line-numbers.nvim',     opts = {}, },  -- show both line number and relative line number
	{ enabled = false, 'SunnyTamang/select-undo.nvim', opts = {} },   -- select part to undo

  { enabled = false,  'jghauser/follow-md-links.nvim', lazy = false },             -- follow markdown links, paths, refs,...
}
