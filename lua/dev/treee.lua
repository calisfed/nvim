--- Treeee
-- TODO: add feature: if normal mode -> visuial select paragraph
-- TODO: add feature: add preset for bars
-- TODO: add feature: take care of blank lines: remove or add a bar '|'
-- NOTE: current implementation: remove, not sure will do the other
---@param opts table
function treee(opts)
	opts.skip_empty = opts.skip_empty or true

	-- local bars = {"|","L"}

---@diagnostic disable-next-line: redundant-value
	vim.cmd([[ execute "normal! \<ESC>" ]])
	local start_line = vim.fn.getcharpos("'<")[2]
	local end_line = vim.fn.getcharpos("'>")[2]
	vim.cmd([[ execute "normal! gv" ]])

	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local indent_stack = {}
	local line_stack = {}
	local prev_indent = 1
	---@diagnostic disable-next-line: unused-local
	for i, line in ipairs(lines) do
		-- gskip empty line
		if #line == 0 and opts.skip_empty == true then
			goto continue
		end
		-- get indent stack
		local indent = line:match("^%s*") or ""
		local cur_indent = #indent
		if cur_indent > prev_indent then
			cur_indent = prev_indent + 1
		end
		prev_indent = cur_indent
		table.insert(indent_stack	, cur_indent)

		print(cur_indent)

		-- get line_stack without space before string
		line = line:gsub("%s", "")
		table.insert(line_stack	, line)
		print(line)

		-- for skip empty line
		::continue::
	end

	-- TODO: algorithm for adding tree
	-- if under it there's level smaller than the current
	-- then add a bar of that level?
	-- e.g: level 4 had 1 under it, so add a bar at level 1 pos

	-- 1 test
		-- 2 test

				-- 3 test
		-- 2 test
			-- 3 test
				-- 4 test
			-- 3 test
			-- 3 test
	-- 1 test
		-- 2 test
	-- 1 test

end

