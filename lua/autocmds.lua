-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})



-- vim.api.nvim_create_autocmd('FocusLost', {
--   desc = "Copy to clipboard on FocusLost",
--   -- set -g focus-events on <== tmux
--   callback = function()
--     vim.fn.setreg("+", vim.fn.getreg("0"))
--   end,
-- })

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   desc = 'Auto indent whole document',
--   group = vim.api.nvim_create_augroup('utils_indent',{ clear = true}),
--   callback = function ()
--     require('utils').indent_and_return()
--   end,
-- })


-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
-- vim.api.nvim_create_autocmd('BufWritePre', {
-- desc = 'Auto format if lsp avaiable',
--   pattern = '*',
--   callback = function(args)
--     require('conform').format { bufnr = args.buf }
--   end,
-- })



-- Disable commenting new lines
-- vim.cmd 'autocmd BufEnter * set formatoptions-=cro'
-- vim.cmd 'autocmd BufEnter * setlocal formatoptions-=cro'
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.cmd.set("fo-=cro")
    -- vim.cmd.set("concealcursor=") -- if set, affect oil.nvim
  end
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "markdown" and vim.api.nvim_win_get_config(0).zindex ~= nil then
      vim.wo.conceallevel = 0
      vim.wo.concealcursor = ""
    end
  end,
})


-- Make sure any opened buffer which is contained in a git repo will be tracked
-- vim.cmd('autocmd BufEnter * :lua require("lazygit.utils").project_root_dir()')

-- http://www.oualline.com/vim-cook.html
-- trim space and tab line::
-- vim.cmd("autocmd BufWritePre * :1,$s/[ <tab>]*$//")

-- Trim trailling spaces
-- vim.cmd [[
--   autocmd BufWritePre * lua Trim_trailing_spaces()
-- ]]

-- Trim trailling spaces using %s
-- function Trim_trailing_spaces()
-- 	local old_pos = vim.fn.getpos '.'
-- 	vim.cmd '%s/\\s\\+$//e'
-- 	vim.fn.setpos('.', old_pos)
-- end
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Remove trailing space",
  callback = function()
    local old_pos = vim.fn.getpos '.'
    vim.cmd '%s/\\s\\+$//e'
    vim.fn.setpos('.', old_pos)
  end
})

-- vim.cmd [[
-- 	autocmd CursorMoved,CursorMovedI * lua Center_cursor()
-- ]]

-- -- This one does not affect snippet completion
-- -- vim.cmd [[
-- --   autocmd CursorMovedI * lua Center_cursor()
-- -- ]]

-- -- Center cursor
-- function Center_cursor()
-- 	if (vim.api.nvim_get_mode()["mode"] == 's') then return end
-- 	local pos = vim.fn.getpos '.'
-- 	vim.cmd 'normal! zz'
-- 	vim.fn.setpos('.', pos)
-- end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  desc = "Always center cursor",
  callback = function()
    if (vim.api.nvim_get_mode()["mode"] == 's') then return end
    local pos = vim.fn.getpos '.'
    vim.cmd 'normal! zz'
    vim.fn.setpos('.', pos)
  end
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  desc = "Make the seperator of split window always White",
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#eeeeee" })
  end
})


-- Separator white
-- vim.cmd [[
-- " 	autocmd BufEnter * hi WinSeparator guifg=#eeeeee
-- " 	autocmd BufEnter * hi MatchParen guibg=standout
-- ]]

vim.filetype.add {
  pattern = {
    [".*/hypr/*.conf"] = "hyprlang",
    [".*/tridactyl/.*"] = "tridactyl"
  },
  -- extension = { htmx = 'htmx' }
}
-- vim.cmd [[
--  autocmd BufEnter * highlight CursorColumn ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=gray gui=bold
-- ]]


-- always open quickfix window automatically.
-- this uses cwindows which will open it only if there are entries.
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("AutoOpenQuickfix", { clear = true }),
  pattern = { "[^l]*" },
  command = "cwindow"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  callback = function()
    vim.b.miniindentscope_disable = true
    vim.b.minisessions_disable = true
    vim.b.minitrailspace_disable = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help" },
  callback = function()
    vim.opt_local.nu = true
    vim.opt_local.rnu = true
    vim.opt_local.wrap = true
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   -- group = vim.api.nvim_create_augroup("vert help", { clear = true }),
--   pattern = { "help"},
--   command = "wincmd L | vertical resize 86"
-- })


-- vim.api.nvim_create_autocmd("FileType", {
-- desc = "replaced by treesitter-hyprlang",
-- 	pattern = { "hyprlang", " */.config/hypr/[^].conf$/gm", },
-- 	callback = function()
-- 		vim.bo.commentstring = '# %s'
-- 	end
-- })


-- https://www.reddit.com/r/vim/comments/1ddvyrx/enhance_search_for_navigation/
-- Basically, it treats every space as a non-gready wildcard
-- vim.cmd(
-- [[ cnoremap <expr> <space> getcmdtype() =~ '[/?]' ? '.\{-}' : "<space>" ]]
-- )

-- vim.cmd [[
-- "autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
-- autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . "%")
--   ]]



-- Remove padding around neovim
-- https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
-- More robust + tested version in Mini.Misc
-- https://github.com/echasnovski/mini.nvim/blob/74e6b722c91113bc70d4bf67249ed8de0642b20e/doc/mini-misc.txt#L171
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})

-- vim.cmd.highlight 'LineNr term=bold cterm=NONE ctermfg=White ctermbg=NONE gui=NONE guifg=#a0a0a0 guibg=NONE'

-- require("cool.line_no_color").setup({
-- 	n = { bg = "Cyan", fg = "#000000", bold = true, },
-- 	i = { bg = "#268834", fg = "#ffffff", bold = true, },
-- 	no = { bg = "#3ddbd9", fg = "#000000", bold = true, },
-- 	R = { bg = "#220088", fg = "#6ea596", bold = true, },
-- 	v = { bg = "#34567f", fg = "#6ea596", bold = true, },
-- 	V = { bg = "#12345a", fg = "#6ea596", bold = true, },
-- })


-- vim.cmd('autocmd BufReadPost * :lua vim.opt_local.wrap=false')

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   callback = function()
--
--     local cwdr = vim.fn.getcwd() .. '.vim'
--     local cwd = cwdr:gsub('/', '%')
--     local ss_dir = vim.fn.stdpath('data') .. '/session/'
--     local file = ss_dir .. cwd
--     print("This: "..file)
--     vim.cmd('mksession! ' .. file)
--   end
-- })


-- -- local ut = require'personal.utils'
-- local function save_session()
--     local cwd = vim.fn.getcwd()
--       -- local session_name = cwd:gsub("/", "\\") .. '.vim'
--       local session_name = "%:p:h:gs?/?\\%?"
--     local session_path = vim.fn.expand("~/.local/share/nvim/session/") .. session_name
--     vim.fn.mkdir(vim.fn.expand("~/.local/share/nvim/session/"), "p")
--     vim.cmd('mksession! ' .. session_path)
--     print('Session saved as ' .. session_path)
-- end

-- -- Map the function to a command for convenience
-- vim.api.nvim_create_user_command('SaveSession', save_session, {})


-- -- Restore cursor to file position in previous editing session
-- vim.api.nvim_create_autocmd("BufReadPost", {
--     callback = function(args)
--         local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
--         local line_count = vim.api.nvim_buf_line_count(args.buf)
--         if mark[1] > 0 and mark[1] <= line_count then
--             vim.cmd('normal! g`"zz')
--         end
--     end,
-- })


-- Not compatible with mini.move M-j M-k stuff
-- -- Keep the cursor position when yanking
-- local cursorPreYank
--
-- vim.keymap.set({ "n", "x" }, "y", function()
--     cursorPreYank = vim.api.nvim_win_get_cursor(0)
--     return "y"
-- end, { expr = true })
--
-- vim.keymap.set("n", "Y", function()
--     cursorPreYank = vim.api.nvim_win_get_cursor(0)
--     return "y$"
-- end, { expr = true })
--
-- vim.api.nvim_create_autocmd("TextYankPost", {
--     callback = function()
--         if vim.v.event.operator == "y" and cursorPreYank then
--             vim.api.nvim_win_set_cursor(0, cursorPreYank)
--         end
--     end,
-- })
--






-- Show cursorline only on active windows
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})


-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = vim.api.nvim_create_augroup("EqualizeSplits", {}),
  callback = function()
    local current_tab = vim.api.nvim_get_current_tabpage()
    vim.cmd("tabdo wincmd =")
    vim.api.nvim_set_current_tabpage(current_tab)
  end,
  desc = "Resize splits with terminal window",
})
-- Behaviour to help "Zoom" behaviour
--
-- local function zoom()
--   local winid = vim.api.nvim_get_current_win()
--   vim.cmd("tab split")
--   local new_winid = vim.api.nvim_get_current_win()
--
--   vim.api.nvim_create_autocmd("WinClosed", {
--     pattern = tostring(new_winid),
--     once = true,
--     callback = function()
--       vim.api.nvim_set_current_win(winid)
--     end,
--   })
-- end
--
-- vim.keymap.set("n", "<leader>zz", zoom)
-- vim.cmd([[
-- function! YankShift()
--   for i in range(9, 1, -1)
--     call setreg(i, getreg(i - 1))
--   endfor
-- endfunction
--
-- au TextYankPost * if v:event.operator == 'y' | call YankShift() | endif
-- ]])
--
--
--



-- local group = vim.api.nvim_create_augroup('OoO', {})
-- local function au(typ, pattern, cmdOrFn)
-- 	if type(cmdOrFn) == 'function' then
-- 		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
-- 	else
-- 		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
-- 	end
-- end
--
-- au({ 'CursorHold', 'InsertLeave' }, nil, function()
-- 	local opts = {
-- 		focusable = false,
-- 		scope = 'cursor',
-- 		close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
-- 	}
-- 	vim.diagnostic.open_float(nil, opts)
-- end)
--
-- au('InsertEnter', nil, function()
-- 	vim.diagnostic.enable(false)
-- end)
--
-- au('InsertLeave', nil, function()
-- 	vim.diagnostic.enable(true)
-- end)



-- Now JJ joins the current line and that below, just like J unmapped did, but now J can take any text object, say Jip to join all lines of the current paragraph
-- vim.cmd [[
--
-- nnoremap <silent> J  :<c-u>set operatorfunc=JoinOperator<CR>g@
-- onoremap J  j
--
-- function! JoinOperator(mode)
--   '[,']join
-- endfunction
--
-- ]]



-- source: https://www.reddit.com/r/neovim/comments/1jm5atz/replacing_vimdiagnosticopen_float_with_virtual/
---@param jumpCount number
local function jumpWithVirtLineDiags(jumpCount)
  pcall(vim.api.nvim_del_augroup_by_name, "jumpWithVirtLineDiags") -- prevent autocmd for repeated jumps

  vim.diagnostic.jump { count = jumpCount }

  local initialVirtTextConf = vim.diagnostic.config().virtual_text
  vim.diagnostic.config {
    virtual_text = false,
    virtual_lines = { current_line = true },
  }

  vim.defer_fn(function() -- deferred to not trigger by jump itself
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "User(once): Reset diagnostics virtual lines",
      once = true,
      group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
      callback = function()
        vim.diagnostic.config { virtual_lines = false, virtual_text = initialVirtTextConf }
      end,
    })
  end, 1)
end

vim.keymap.set("n", "ge", function() jumpWithVirtLineDiags(1) end, { desc = "󰒕 Next diagnostic" })
vim.keymap.set("n", "gE", function() jumpWithVirtLineDiags(-1) end, { desc = "󰒕 Prev diagnostic" })




-- Clear jump list when vim starts, not so good

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.cmd.clearjumps()
-- 	end,
-- })


-- https://www.reddit.com/r/neovim/comments/1kllass/with_r_being_deprecated_in_011_how_can_i_have_two/
-- function _G._status_col()
--   --
--   return "%s %l " .. vim.v.relnum
-- end

-- vim.o.statuscolumn = "%{%v:lua._status_col()%}"




-- vim.diagnostic.config {
-- 	-- virtual_text = false,
-- 	virtual_lines = false,
-- 	virtual_text = false,
-- 	-- virtual_lines = {
-- 	--   current_line = false,
-- 	-- },
-- }


vim.diagnostic.config({
  signs = {
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    },
    text = {
      [vim.diagnostic.severity.ERROR] = "X",
      [vim.diagnostic.severity.HINT] = "?",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.WARN] = "!",
    },
  },
  update_in_insert = true,
  virtual_text = false,
  float = { border = 'single' }

  -- virtual_lines = { current_line = true },
})


-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
-- 	vim.lsp.handlers.hover, {
-- 		border = 'single',
--     title = 'Hover'
-- 	}
-- )


vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  config = config or {}
  config.border = 'single'
  local bufnr, winnr = vim.lsp.util.open_floating_preview(result.contents, "markdown", config)
  vim.wo[winnr].conceallevel = 0
  vim.wo[winnr].concealcursor = ""
  return bufnr, winnr
end

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = 'single'
  }
)


---
-- function Treeify()
-- 	-- get start and end pos
-- 	vim.cmd([[ execute "normal! \<ESC>" ]])
-- 	local start_line = vim.fn.getcharpos("'<")[2]
-- 	local end_line = vim.fn.getcharpos("'>")[2]
-- 	vim.cmd([[ execute "normal! gv" ]])

-- 	local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
-- 	local stack = {}
-- 	local new_lines = {}

-- 	  for i, line in ipairs(lines) do
-- 	    local indent = line:match("^%s*") or ""
-- 	    local level = #indent / 2

-- 	    -- remove stack items deeper than current
-- 	    while #stack > level do table.remove(stack) end

-- 	    local is_last = true
-- 	    for j = i+1, #lines do
-- 	      local next_indent = lines[j]:match("^%s*") or ""
-- 	      if #next_indent / 2 == level then
-- 	        is_last = false
-- 	        break
-- 	      elseif #next_indent / 2 < level then
-- 	        break
-- 	      end
-- 	    end

-- 	    local prefix = ""
-- 	    if level > 0 then
-- 	      for l = 1, level - 1 do
-- 	        -- prefix = prefix .. "│   "
-- 	        prefix = prefix .. "  "
-- 	      end
-- 	      prefix = prefix .. (is_last and " └── " or " ├── ")
-- 	    end

-- 	    table.insert(new_lines, prefix .. line:gsub("^%s*", ""))
-- 	    stack[level + 1] = true
-- 	  end

-- 	  vim.api.nvim_buf_set_lines(0, start_line, end_line, false, new_lines)

-- end

-- vim.api.nvim_create_autocmd('BufRead', {
--   callback = function(opts)
--     vim.api.nvim_create_autocmd('BufWinEnter', {
--       once = true,
--       buffer = opts.buf,
--       callback = function()
--         local ft = vim.bo[opts.buf].filetype
--         local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
--         if
--             not (ft:match('commit') and ft:match('rebase'))
--             and last_known_line > 1
--             and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
--         then
--           vim.api.nvim_feedkeys([[g`"]], 'nx', false)
--         end
--       end,
--     })
--   end,
-- })

-- vim.api.nvim_create_autocmd('BufRead', {
--   pattern = {"*.norg"},
--   callback = function ()

--   end
-- })

-- Zig
-- Code Action on save
-- vim.api.nvim_create_autocmd('BufWritePre',{
--   desc= "Fix all small error",
--   pattern = {"*.zig", "*.zon"},
--   callback = function(ev)
--     vim.lsp.buf.code_action({
--       context = { only = { "source.fixAll" } },
--       apply = true,
--     })
--   end
-- })
-- vim.api.nvim_create_autocmd('BufWritePre',{
--   desc = "Organize import",
--   pattern = {"*.zig", "*.zon"},
--   callback = function(ev)
--     vim.lsp.buf.code_action({
--       context = { only = { "source.organizeImports" } },
--       apply = true,
--     })
--   end
-- })
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = "Format on save for zig",
  pattern = { "*.zig", "*.zon" },
  callback = function(ev)
    vim.lsp.buf.format()
  end
})


vim.api.nvim_create_autocmd('BufWinLeave', {
  desc = "Save view before exit",
  pattern = { "*.*" },
  callback = function()
    vim.cmd("mkview")
  end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = "Load view after enter",
  pattern = { "*.*" },
  callback = function()
    vim.cmd("silent! loadview")
  end
})


-- vim.api.nvim_create_autocmd({"BufReadPost", "FileReadPost"}, {
--   desc = "Ensure folds are expanded when open file",
--   pattern = "*",
--   -- command = "normal! zR"
--   callback = function ()
--     vim.cmd("normal! zR")
--   end
-- })


-- Auto command to stop LSP when UndoTree is opened
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "undotree" then
      for _, client in pairs(vim.lsp.get_active_clients()) do
        vim.lsp.stop_client(client.id)
      end
    end
  end,
})



