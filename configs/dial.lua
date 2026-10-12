
vim.pack.add({ "https://github.com/monaqa/dial.nvim" })
local map = require("dial.map")
vim.keymap.set("n", "<c-a>", function() map.manipulate("increment", "normal") end, { desc = "dial inc" })
vim.keymap.set("n", "<c-x>", function() map.manipulate("decrement", "normal") end, { desc = "dial dec" })
vim.keymap.set("n", "g<c-a>", function() map.manipulate("increment", "gnormal") end, { desc = "dial inc" })
vim.keymap.set("n", "g<c-x>", function() map.manipulate("decrement", "gnormal") end, { desc = "dial dec" })
vim.keymap.set("v", "<c-a>", function() map.manipulate("increment", "visual") end, { desc = "dial inc" })
vim.keymap.set("v", "<c-x>", function() map.manipulate("decrement", "visual") end, { desc = "dial dec" })
vim.keymap.set("v", "g<c-a>", function() map.manipulate("increment", "gvisual") end, { desc = "dial inc" })
vim.keymap.set("v", "g<c-x>", function() map.manipulate("decrement", "gvisual") end, { desc = "dial dec" })
local augend = require("dial.augend")
require("dial.config").augends:register_group({
	-- default augends used when no group name is specified
	default = {
		augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
		augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
		augend.constant.alias.bool, -- boolean value (true <-> false)
		augend.constant.new({
			elements = { "and", "or" },
			word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
			cyclic = true -- "or" is incremented into "and".
		}),
		augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
		augend.constant.new({ elements = { "[x]", "[ ]" }, word = false, cyclic = true })
	},
	neorg = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.constant.alias.bool,
		augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
		augend.constant.new({
			elements = { "( )", "(x)", "(?)", "(!)", "(+)", "(-)", "(=)", "(_)" },
			word = false,
			cyclic = true
		}),
		augend.constant.new({ elements = { "*", "**", "***", "****", "*****", "******" }, word = false, cyclic = false }),
		augend.constant.new({ elements = { "-", "--", "---", "----", "-----", "------" }, word = false, cyclic = false }),
		augend.constant.new({ elements = { "~", "~~", "~~~", "~~~~", "~~~~~", "~~~~~~" }, word = false, cyclic = false }),
		augend.constant.new({ elements = { ">", ">>", ">>>", ">>>>", ">>>>>", ">>>>>>" }, word = false, cyclic = false })
	},
	asciidoc = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.constant.alias.bool,
		augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "[ ]", "[x]" }, word = true, cyclic = true }),
		augend.constant.new({ elements = { "=", "==", "===", "====", "=====", "======" }, word = false, cyclic = false }),
		augend.constant.new({ elements = { "*", "**", "***", "****", "*****", "******" }, word = false, cyclic = false }),
		augend.constant.new({
			elements = { "note:", "important:", "tip:", "caution:", "warning:" },
			word = true,
			cyclic = true
		})
	},
	-- augends used when group with name `mygroup` is specified
	mygroup = {
		augend.integer.alias.decimal,
		augend.date.alias["%m/%d/%Y"] -- date (02/19/2022, etc.)
	}
})

-- -- change augends in visual mode
-- vim.keymap.set("v", "<c-a>", require("dial.map").inc_visual("visual"), {noremap = true})
-- vim.keymap.set("v", "<c-x>", require("dial.map").dec_visual("visual"), {noremap = true})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.norg" },
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<c-a>", require("dial.map").inc_normal("neorg"),
			{ noremap = true, desc = "dial inc neorg" })
		vim.api.nvim_buf_set_keymap(0, "n", "<c-x>", require("dial.map").dec_normal("neorg"),
			{ noremap = true, desc = "dial dec neorg" })
		vim.api.nvim_buf_set_keymap(0, "v", "<c-a>", require("dial.map").inc_visual("neorg"),
			{ noremap = true, desc = "dial inc neorg" })
		vim.api.nvim_buf_set_keymap(0, "v", "<c-x>", require("dial.map").dec_visual("neorg"),
			{ noremap = true, desc = "dial dec neorg" })
	end
})

