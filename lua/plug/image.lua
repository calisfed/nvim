return
{
  "3rd/image.nvim",
  lazy = false,
  build = false,
  enabled = false,
  -- event = 'VeryLazy',
  dependencies = { { "vhyrro/luarocks.nvim", priority = 1000, config = true, } },
  config = function()
    -- default config
    require("image").setup({
      backend = "ueberzug", --ueberzug or kitty
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = false,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        typst = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = false,
          only_render_image_at_cursor = true,
          filetypes = { "typst", "typ" },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = false,
          only_render_image_at_cursor = true,
          filetypes = { "norg" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      -- window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      window_overlap_clear_ft_ignore = { "noice", "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
      editor_only_render_when_focused = false,                                            -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = true,                                             -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    })
  end
}
