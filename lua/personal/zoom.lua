local M = {}

local api = vim.api

local zoom_win = nil
local overlay_win = nil

local config = {
  width = 120,
  height_ratio = 0.95,
  dim_color = "#171928",
  dim_blend = 10, -- 0 = solid black, 100 = transparent
}

local function cleanup()
  local overlay = overlay_win

  zoom_win = nil
  overlay_win = nil

  if overlay and api.nvim_win_is_valid(overlay) then
    api.nvim_win_close(overlay, true)
  end
end

function M.zoom()
  -- Toggle off
  if zoom_win and api.nvim_win_is_valid(zoom_win) then
    local win = zoom_win
    api.nvim_win_close(win, true)
    cleanup()
    return
  end

  cleanup()

  local source_win = api.nvim_get_current_win()
  local source_buf = api.nvim_win_get_buf(source_win)
  local cursor = api.nvim_win_get_cursor(source_win)

  local editor_width = vim.o.columns
  local editor_height = vim.o.lines - vim.o.cmdheight - 1

  local width = math.min(config.width, editor_width)
  local height = math.max(1, math.floor(editor_height * config.height_ratio))

  local col = math.floor((editor_width - width) / 2)
  local row = math.floor((editor_height - height) / 2)

  -- Define dim highlight
  api.nvim_set_hl(0, "ZoomDim", {
    bg = config.dim_color,
  })

  -- Create background overlay
  local overlay_buf = api.nvim_create_buf(false, true)

  overlay_win = api.nvim_open_win(overlay_buf, false, {
    relative = "editor",
    row = 0,
    col = 0,
    width = editor_width,
    height = editor_height,
    style = "minimal",
    focusable = false,
    zindex = 40,
  })

  vim.wo[overlay_win].winhighlight = "Normal:ZoomDim,NormalFloat:ZoomDim"
  vim.wo[overlay_win].winblend = config.dim_blend

  -- Create zoomed floating window
  zoom_win = api.nvim_open_win(source_buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "none",
    zindex = 50,
  })

  -- Restore cursor position
  api.nvim_win_set_cursor(zoom_win, cursor)

  -- Copy useful window-local options
  for _, opt in ipairs({
    "number",
    "relativenumber",
    "wrap",
    "signcolumn",
    "foldcolumn",
    "cursorline",
    "list",
    "spell",
  }) do
    vim.wo[zoom_win][opt] = vim.wo[source_win][opt]
  end

  -- Automatically remove overlay when zoom closes
  local current_zoom = zoom_win

  api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(current_zoom),
    once = true,
    callback = function()
      if zoom_win == current_zoom then
        cleanup()
      end
    end,
  })
end

return M
