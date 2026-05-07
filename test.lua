function plugins_list(list)
    for _, plug in pairs(list) do
        plug.src = plug.src or plug[0]
        plug.add = plug.add or false
        -- print(vim.inspect(plug))
        if plug.add == true then
            vim.pack.add(plug.src )
        end
    end
end

a = {

    { add = true, src = 'https://github.com/rachartier/tiny-code-action.nvim', },       -- require telescope/fzf for code actions
    { add = true, src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim', }, -- inline diagnostic
    { add = true, src = 'https://github.com/kdheepak/lazygit.nvim', },                   -- git integration
    { add = true, src = 'https://github.com/lambdalisue/suda.vim', },                   -- auto read/write file with sudo
}

plugins_list(a)
