vim.keymap.set('n', '<leader><leader>', '<cmd>source %<cr>')
print("tho has been sourced " .. vim.api.nvim_buf_get_name(0))

-- buffer and window creation
local current_win = vim.api.nvim_get_current_win()
local win_config = vim.api.nvim_win_get_config(current_win)
local width = 50
local height = 1
local editor_width = vim.api.nvim_win_get_width(current_win)
local editor_height = vim.api.nvim_win_get_height(current_win)
local row = math.floor((editor_height - height) / 2)

local col = math.floor((editor_width - width) / 2)
local buf = vim.api.nvim_create_buf(false, true)     -- just a scratch buffer

local win = vim.api.nvim_open_win(buf, true, {
  relative = "win",
  win = current_win,
  width = width,
  height = height,
  -- row = row,
  row = vim.o.lines - vim.o.cmdheight,
  col = col,
  border = 'none',
  title = "cmd",
  title_pos = 'center',
})




-- get command-line history
local history_type = "cmd"     -- ":" commands
local history_count = 20       -- how many latest entries

-- vim.fn.histget("cmd", -n) gives the nth last item
local hist = {}
local total = vim.fn.histnr(history_type)
local start_idx = math.max(1, total - history_count + 1)

for i = start_idx, total do
  local entry = vim.fn.histget(history_type, i)
  if entry ~= "" then
    table.insert(hist, entry)
  end
end
table.insert(hist, '')                                  --blank line at the end

vim.api.nvim_buf_set_lines(buf, 0, -1, false, hist)     -- put history into buffer



-- set cursor location and mode
local last_line = vim.api.nvim_buf_line_count(buf)
vim.api.nvim_win_set_cursor(win, { last_line, 0 })
vim.api.nvim_command('startinsert')


-- completion source for native/mini.completion

_G.zzz_complete = function(findstart, base)
  if findstart == 1 then
    -- find start position of word
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".") - 1

    while col > 0 and line:sub(col, col):match("[%w_:.-]") do
      col = col - 1
    end

    return col
  else
    -- get current line before cursor
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col(".") - 1
    local input = line:sub(1, col)

    -- get completion list
    -- local matches = vim.fn.getcompletion(input, 'cmdline') -- where is the vim.api stuff
    -- local matches = vim.fn.getcompletion(input, 'command') -- where is the vim.api stuff

    local items = {}

    for _, v in ipairs(vim.fn.getcompletion(base, "cmdline")) do
      table.insert(items, v)
    end

    for _, v in ipairs(vim.fn.getcompletion(base, "runtime")) do
      table.insert(items, v)
    end
    return items
    -- return matches
  end
end

_G.zzx_complete = function(findstart, base)
  if findstart == 1 then
    return 0
  end

  local items = {}

  -- 1. LSP completion (Lua)
  local ok, lsp_items = pcall(function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local client = clients[1]
    -- local client = ''

    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
    -- local params = vim.lsp.util.make_position_params(0)
    local res = vim.lsp.buf_request_sync(0, "textDocument/completion", params, 1000)

    local out = {}

    if res then
      for _, r in pairs(res) do
        if r.result then
          local list = r.result.items or r.result
          for _, item in ipairs(list) do
            table.insert(out, item.label or item.insertText)
          end
        end
      end
    end
    -- print(vim.inspect(out))
    return out
  end)

  if ok and lsp_items then
    vim.list_extend(items, lsp_items)
  end

  -- 2. cmdline completion
  vim.list_extend(items, vim.fn.getcompletion(base, "cmdline"))

  -- print(vim.inspect(items))
  -- filter
  local filtered = {}
  for _, v in ipairs(items) do
    if v and v:find("^" .. vim.pesc(base)) then
      table.insert(filtered, v)
    end
  end

  return filtered
end
-- Set buffer filetype
vim.wo[win].number = false
vim.wo[win].relativenumber = false
vim.wo[win].cursorline = false
-- vim.wo[win].winfixbuf = true
vim.bo[buf].bufhidden = "wipe"
vim.bo[buf].buftype = "nofile"


-- these option needed for this to work
vim.bo[buf].ft = 'lua'
vim.bo[buf].omnifunc = 'v:lua.zzz_complete'     -- TODO: make source local
-- vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'                                   -- TODO: make source local
-- vim.bo[buf].omnifunc = 'v:lua.MiniCmdline.default_autocomplete_predicate'
vim.bo[buf].complete = ".,o"                                                      -- use buffer and omnifunc
vim.bo[buf].completeopt = "fuzzy,menuone,noinsert"                                -- add 'popup' for docs (sometimes)

vim.keymap.set('i', '<cr>', function() print1line(buf) end, { buffer = buf })     -- buffer keymap, same with buffer=true, will be wiped when buffer deleted
vim.keymap.set('n', 'q', '<cmd>bdelete<cr>', { buf = buf })
vim.keymap.set('n', '<Esc>', '<cmd>bdelete<cr>', { buf = buf })

-- function printallline(buf)
--   local lines = vim.api.nvim_buf_get_lines(buf, -2, -1, false)
--   local one_line = table.concat(lines, " ")
--   vim.api.nvim_buf_delete(buf, {}) -- delete the cmdline buffer
--   print(one_line)                  -- TODO: execute command here
--   vim.api.nvim_input('<Esc><Esc>') -- what a way to go back to normal mode in original buffer :/
-- end

function print1line(buf)
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_buf_delete(buf, {})       -- delete the cmdline buffer
  print(line)                            -- TODO: execute command here
  vim.api.nvim_exec2(line, {})
  vim.api.nvim_input('<Esc><Esc>')       -- what a way to go back to normal mode in original buffer :/
end

-- TODO: nvim_exec2? and how to do the range thing

-- vim.api.nvim_create_autocmd("CmdwinEnter", function()
--   vim.api.nvim_input("<C-f>")
-- end)

-- vim.keymap.set("n","<leader>;","<Esc>q:i")
