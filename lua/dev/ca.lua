local M = {}
local ASD = {}
M.ca = function ()
local bufnr = vim.api.nvim_get_current_buf()
local params = vim.lsp.util.make_range_params()

params.context = {
    triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
}

vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(error, results, context, config)
  -- results is an array of lsp.CodeAction
		print(results)
end)

end
return M
