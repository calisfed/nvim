local M = {}

if pcall(require, "snipe") then
  local snipe = require("snipe")
  snipe.ui_select_menu = require("snipe.menu"):new { position = "center", dictionary = "123qweasdzxc", }
  snipe.ui_select_menu:add_new_buffer_callback(function(m)
    vim.keymap.set("n", "<esc>", function()
      m:close()
    end, { nowait = true, buffer = m.buf })
  end)
  vim.ui.select = snipe.ui_select;
end

function M.getList()
  local w = "man -f " .. vim.fn.expand("<cword>") .. " | sort -f"
  local list = vim.fn.system(w)
  return list
end

function M.parseInfo(input)
  local result = {}
  for line in input:gmatch("[^\n]+") do
    local name, section, desc = line:match("(%S+)%s*%((%w+)%)%s*-%s*(.*)")
    if string.len(section) == 1 then
      section = section .. " "
    end
    table.insert(result, { name = name, section = section, desc = desc })
  end
  return result
end

function M.onSelect(item)
  vim.cmd("vert Man " .. item.section .. " " .. item.name)
end

function M.run()
  local b = M.parseInfo(M.getList())
  vim.ui.select(b, {
    format_item = function(item)
      return item.section .. " | " .. item.name .. ": " .. item.desc
    end
  }, M.onSelect)
end

-- Straight from snipe.nvim
local Buffer = {
  id = 0,
  name = "",
  classifiers = "     ", -- see :help ls for more info
}

Buffer.__index = Buffer

M.Buffer = Buffer

-- Converts single line from ":buffers" output
function Buffer:from_line(s)
  local o = setmetatable({}, Buffer)

  o.id = tonumber(vim.split(s, " ", { trimempty = true })[1])
  o.classifiers = s:sub(4, 8)

  local ss = s:find('"')
  local se = #s - s:reverse():find('"')

  o.name = s:sub(ss + 1, se)

  return o
end

function M.get_buffers(cmd)
  cmd = cmd or "ls"
  local bufs_out = vim.api.nvim_exec2(cmd, { output = true }).output
  local bufs = vim.split(bufs_out, "\n", { trimempty = true })
  return vim.tbl_map(function(l) return Buffer:from_line(l) end, bufs)
end


return M

-- printf
