return
{
  "vhyrro/luarocks.nvim",
  enabled = false,
  priority = 1001,   -- this plugin needs to run before anything else
  opts = function()
    local config = {
      rocks = { "magick" },
    }
    return config
  end
}
