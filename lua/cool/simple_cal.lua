-- https://www.reddit.com/r/neovim/comments/1d8yeb0/simple_calculator_in_neovim/

-- request neovim v0.10+ for vim.ui.input
vim.keymap.set("i", "<C-,>", function()
  vim.ui.input({ prompt = "😄Calculator: " }, function(input)
    local calc = load("return " .. (input or ""))()
    if (calc) then
      vim.api.nvim_feedkeys(tostring(calc), "i", true)
    end
  end)
end)
