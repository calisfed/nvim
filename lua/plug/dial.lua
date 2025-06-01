return {
	enabled = false,
	lazy = false,
	'monaqa/dial.nvim',
	config = function()
		-- require('dial').setup()
		local map = require('dial.map')
		vim.keymap.set("n", "<C-a>", function() map.manipulate("increment", "normal") end)
		vim.keymap.set("n", "<C-x>", function() map.manipulate("decrement", "normal") end)
		vim.keymap.set("n", "g<C-a>", function() map.manipulate("increment", "gnormal") end)
		vim.keymap.set("n", "g<C-x>", function() map.manipulate("decrement", "gnormal") end)
		vim.keymap.set("v", "<C-a>", function() map.manipulate("increment", "visual") end)
		vim.keymap.set("v", "<C-x>", function() map.manipulate("decrement", "visual") end)
		vim.keymap.set("v", "g<C-a>", function() map.manipulate("increment", "gvisual") end)
		vim.keymap.set("v", "g<C-x>", function() map.manipulate("decrement", "gvisual") end)
		local augend = require("dial.augend")
		require("dial.config").augends:register_group {
			-- default augends used when no group name is specified
			default = {
				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
				augend.integer.alias.hex,  -- nonnegative hex number  (0x01, 0x1a1f, etc.)
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				augend.constant.alias.bool, -- boolean value (true <-> false)
				augend.constant.new {
					elements = { "and", "or" },
					word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
					cyclic = true, -- "or" is incremented into "and".
				},
				augend.constant.new {
					elements = { "&&", "||" },
					word = false,
					cyclic = true,
				},
			},

			-- augends used when group with name `mygroup` is specified
			mygroup = {
				augend.integer.alias.decimal,
				augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
			}
		}

		-- -- change augends in VISUAL mode
		-- vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual("visual"), {noremap = true})
		-- vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual("visual"), {noremap = true})

		-- autocmd FileType typescript lua vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("typescript"), {noremap = true})
		-- autocmd FileType typescript lua vim.api.nvim_buf_set_keymap(0, "n", "<C-x>", require("dial.map").dec_normal("typescript"), {noremap = true})
	end
}
