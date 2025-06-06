return {
	enabled = false,
	'windwp/nvim-ts-autotag',
	lazy =false,
	-- ft = {"markdown", "html"},
	opts = function()
		require('nvim-ts-autotag').setup({
			opts = {
				-- Defaults
				enable_close = true,      -- Auto close tags
				enable_rename = true,     -- Auto rename pairs of tags
				enable_close_on_slash = false -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			-- per_filetype = {
			-- 	["html"] = {
			-- 		enable_close = true
			-- 	}
			-- }
		})
		-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
		-- 	vim.lsp.diagnostic.on_publish_diagnostics,
		-- 	{
		-- 		underline = true,
		-- 		virtual_text = {
		-- 			spacing = 5,
		-- 			severity_limit = 'Warning',
		-- 		},
		-- 		update_in_insert = true,
		-- 	}
		-- )
	end
}
