--
-- local tm = vim.uv.new_timer();
-- local r = 0;
--
-- tm:start(0, 50, vim.schedule_wrap(function ()
--   if r > 10 then
--     vim.print(r);
--     tm:stop();
--     tm:close();
--     vim.api.nvim_input("I");
--     return 0;
--   end
--
--   r = r + 1;
-- end));


local function stringToArray(str)
    local array = {}
    for i = 1, #str do
        array[i] = str:sub(i, i)
    end
    return array
end

local text = "Hello, Lua!"
local textArray = stringToArray(text)
local tm = vim.uv.new_timer();
local r = 1;

tm:start(1, 500, vim.schedule_wrap(function ()
  if r > 100 or r > string.len(text) then
    vim.print(r);
    -- tm:stop();
    tm:close();
    return;
  end
  vim.api.nvim_input("I")
  vim.api.nvim_input(textArray[r])
  vim.api.nvim_input("<Esc>")
  r = r + 1;
end));

