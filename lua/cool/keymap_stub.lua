local function keymap_stub(mode, lhs, callback, opts)
  keymap.set(mode, lhs, function()
    keymap.del(mode, lhs)
    callback()
    api.nvim_input(lhs) -- replay keybind
  end, opts)
end

local function command_stub(c, callback)
  api.nvim_create_user_command(c, function()
    api.nvim_del_user_command(c) -- remove stub command
    callback()
    cmd(c)
  end, {})
end

local function require_stub(mod, callback)
  package.preload[mod] = function()
    package.loaded[mod] = nil
    package.preload[mod] = nil
    return callback()
  end
end


--  keymap_stub simply puts a skeleton keymap in place and call the callback when it is triggered. Pretty much the lazy.nvim keys field.
--
-- command_stub is pretty much the same as keymap_stub but for a command, akin to lazy.nvim cmd field.
--
-- require_stub (WARNING HACK). This just lets you pre-declare modules that may need to be loaded by another package on demand. E.g. for harpoon I add this so that plenary is lazy loaded:
--
-- require_stub("plenary.path", function()
--   cmd.packadd "plenary.nvim"
--   return require("plenary.path")
-- end)
--
-- I don't know if anybody will find these little functions useful besides me, but I thought I'd share. My full configuration is at https://codeberg.org/cathalo/.f/src/branch/main/.config/nvim . In general I try to keep it in a single file (IO is slow people !).
