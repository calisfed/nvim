-- Code copy from
-- https://github.com/folke/snacks.nvim/blob/main/lua/snacks/bigfile.lua

local opts = {
  size = 1.5 * 1024 * 1024, -- 1.5MB
  line_length = 1000,
  setup = function(ctx)
    if vim.fn.exists(":NoMatchParen") ~= 0 then
      vim.cmd([[NoMatchParen]])
    end
    -- TODO: set winndow option
    -- Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })

    vim.b.minianimate_disable = true
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ctx.buf) then
        vim.bo[ctx.buf].syntax = ctx.ft
      end
    end)
  end
}

function big_file(opts)
  vim.filetype.add({
    pattern = {
      [".*"] = {
        function(path, buf)
          if not path or not buf or vim.bo[buf].filetype == "bigfile" then
            return
          end
          if path ~= vim.api.nvim_buf_get_name(buf) then
            return
          end
          local size = vim.fn.getfsize(path)
          if size <= 0 then
            return
          end
          if size > opts.size then
            return "bigfile"
          end
          local lines = vim.api.nvim_buf_line_count(buf)
          return (size - lines) / lines > opts.line_length and "bigfile" or nil
        end,
      },
    },
  })


  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("bigfile", { clear = true }),
    pattern = "bigfile",
    callback = function(ev)
      if opts.notify then
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ":p:~:.")
        -- Snacks.notify.warn({
        --   ("Big file detected `%s`."):format(path),
        --   "Some Neovim features have been **disabled**.",
        -- }, { title = "Big File" })
      end
      vim.api.nvim_buf_call(ev.buf, function()
        opts.setup({
          buf = ev.buf,
          ft = vim.filetype.match({ buf = ev.buf }) or "",
        })
      end)
    end,
  })
end

big_file(opts)
