







vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui" })

local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" },
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input(
				"Path to executable: ",
				vim.fn.getcwd() .. "/",
				"file"
			)
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach to process",
		type = "cpp", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = "attach",
		pid = require("dap.utils").pick_process,
		args = {},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.zig = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input(
				"Path to executable: ",
				vim.fn.getcwd() .. "/zig-out/bin/",
				"file"
			)
		end,
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
	},
}

dap.configurations.rust = {
	vim.tbl_deep_extend("force", dap.configurations.cpp[1], {
		initCommands = function()
			-- Find out where to look for the pretty printer Python module
			local rustc_sysroot =
			    vim.fn.trim(vim.fn.system("rustc --print sysroot"))

			local script_import = 'command script import "'
			    .. rustc_sysroot
			    .. '/lib/rustlib/etc/lldb_lookup.py"'
			local commands_file = rustc_sysroot
			    .. "/lib/rustlib/etc/lldb_commands"

			local commands = {}
			local file = io.open(commands_file, "r")
			if file then
				for line in file:lines() do
					table.insert(commands, line)
				end
				file:close()
			end
			table.insert(commands, 1, script_import)

			return commands
		end,
	}),
	unpack(dap.configurations.cpp, 2, #dap.configurations.cpp),
}

dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	-- works with go.mod packages and sub packages
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

dap.adapters.python = {
	type = "executable",
	command = "/bin/python",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "/usr/bin/python"
		end,
	},
}
dap.adapters.nlua = function(callback, config)
	callback({
		type = "server",
		host = config.host,
		port = config.port,
	})
end

dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
		host = function()
			local value = vim.fn.input("Host [127.0.0.1]: ")
			if value ~= "" then
				return value
			end
			return "127.0.0.1"
		end,
		port = function()
			local val = tonumber(vim.fn.input("Port: ", "8086"))
			assert(val, "Please provide a port number")
			return val
		end,
	},
}

vim.keymap.set("n", "<leader>dR", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor", })
vim.keymap.set("n", "<leader>dE", function() require("dapui").eval(vim.fn.input("[Expression] > ")) end,
	{ desc = "Evaluate Input", })
vim.keymap.set({ "n", "v" }, "<leader>de", function() require("dapui").eval() end, { desc = "Evaluate", })
vim.keymap.set("n", "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input("[Condition] > ")) end,
	{ desc = "Conditional Breakpoint", })
vim.keymap.set("n", "<leader>dL",
	function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
	{ desc = "Set Breakpoint", silent = true, })
vim.keymap.set("n", "<leader>dU", function() require("dapui").toggle() end, { desc = "Toggle UI", })
vim.keymap.set("n", "<leader>dp", function() require("dap").pause.toggle() end, { desc = "Pause", })
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle REPL", })
vim.keymap.set("n", "<leader>dt", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint", })
vim.keymap.set("n", "<leader>dB", function() require("dap").step_back() end, { desc = "Step Back", })
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue", })
vim.keymap.set("n", "<leader>ds", function() require("dap").continue() end, { desc = "Start", })
vim.keymap.set("n", "<leader>dd", function() require("dap").disconnect() end, { desc = "Disconnect", })
vim.keymap.set("n", "<leader>dg", function() require("dap").session() end, { desc = "Get Session", })
vim.keymap.set("n", "<leader>dh", function() require("dap.ui.widgets").hover() end, { desc = "Hover Variables", })
vim.keymap.set("n", "<leader>dS", function() require("dap.ui.widgets").scopes() end, { desc = "Scopes", })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into", })
vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over", })
vim.keymap.set("n", "<leader>du", function() require("dap").step_out() end, { desc = "Step Out", })
vim.keymap.set("n", "<leader>dq", function() require("dap").close() end, { desc = "Quit", })
vim.keymap.set("n", "<leader>dx", function() require("dap").terminate() end, { desc = "Terminate", })
vim.keymap.set("n", "<leader>dO", function() require("dap").repl.open() end, { desc = "Repl Open", silent = true, })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last", silent = true, })



require "dapui".setup({
	icons = {
		expanded = "▾",
		collapsed = "▸",
		current_frame = "▸",
	},
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Use this to override mappings for specific elements
	element_mappings = {
		-- Example:
		-- stacks = {
		--   open = "<CR>",
		--   expand = "o",
		-- }
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7") == 1,
	-- Layouts define sections of the screen to place windows.
	-- The position can be "left", "right", "top" or "bottom".
	-- The size specifies the height/width depending on position. It can be an Int
	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
	-- Elements are the elements shown in the layout (in order).
	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.4 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40, -- 40 columns
			position = "right",
		},
		{
			elements = {
				"repl",
				-- "console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "↻",
			terminate = "",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
	},
})
