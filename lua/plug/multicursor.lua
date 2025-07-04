return{
	enabled = false,
	-- event = "VeryLazy",
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	keys = {
		{"<m-up>", function () require('multicursor-nvim').addCursor("k") end, desc = "MultiCursor - Add above" },
		{"<m-down>", function () require('multicursor-nvim').addCursor("j") end, desc = "MultiCursor - Add below" }
	},
	config = function ()
		local mc = require("multicursor-nvim")


		-- Add cursors above/below the main cursor.
		vim.keymap.set({ "n", "v" }, "<m-up>", function() mc.addCursor("k") end, { desc = "MultiCursor - Add above" })
		vim.keymap.set({ "n", "v" }, "<m-down>", function() mc.addCursor("j") end, { desc = "MultiCursor - Add below" })

		-- Add a cursor and jump to the next word under cursor.
		vim.keymap.set({ "n", "v" }, "<m-n>", function() mc.addCursor("*") end, { desc = "MultiCursor - Add and jump to next word" })

		-- Jump to the next word under cursor but do not add a cursor.
		vim.keymap.set({ "n", "v" }, "<m-s>", function() mc.skipCursor("*") end, { desc = "MultiCursor - Add and jump to next word" })

		-- Rotate the main cursor.
		vim.keymap.set({ "n", "v" }, "<m-left>", mc.nextCursor, { desc = "MC - Rotate left the main cursor" })
		vim.keymap.set({ "n", "v" }, "<m-right>", mc.prevCursor, { desc = "MC - Rotate right the main cursor" })

		-- Delete the main cursor.
		vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor, { desc = "MC - Delete cursor" })

		-- Add and remove cursors with control + left click.
		vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse, { desc = "MC - Add/Remove cursor w/ Ctrl+leftclick" })

		vim.keymap.set({ "n", "v" }, "<c-q>", function()
			if mc.cursorsEnabled() then
				-- Stop other cursors from moving.
				-- This allows you to reposition the main cursor.
				mc.disableCursors()
			else
				mc.addCursor()
			end
		end, { desc = "MC - Stop cursor from moving" })

		vim.keymap.set("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
				-- Default <esc> handler.
			end
		end)

		-- Align cursor columns.
		vim.keymap.set("n", "<leader>a", mc.alignCursors, { desc = "MC_Align cursor columns" })

		-- -- Split visual selections by regex.
		-- vim.keymap.set("v", "S", mc.splitCursors, { desc = "MC_Split visual selections by regex" })
		--
		-- -- Append/insert for each line of visual selections.
		-- vim.keymap.set("v", "I", mc.insertVisual, { desc = "MC_Insert for each line of visual selection" })
		-- vim.keymap.set("v", "A", mc.appendVisual, { desc = "MC_Append for each line of visual selection" })
		--
		-- -- match new cursors within visual selections by regex.
		-- vim.keymap.set("v", "M", mc.matchCursors, { desc = "MC_Match new cursos w/in visual selections by regex" })
		--
		-- -- Rotate visual selection contents.
		-- vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end, { desc = "Rotate visual selection contents" })
		-- vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end, { desc = "Rotate visual selection contents" })

		-- -- Customize how cursors look.
		-- vim.cmd.hi("link", "MultiCursorCursor", "Cursor")
		-- vim.cmd.hi("link", "MultiCursorVisual", "Visual")
		-- vim.cmd.hi("link", "MultiCursorDisabledCursor", "Visual")
		-- vim.cmd.hi("link", "MultiCursorDisabledVisual", "Visual")

	end,
}
