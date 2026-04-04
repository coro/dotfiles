-- Shared language registry.
-- Language files call M.register() to declare their tools.
-- Plugin setup files read from the collected tables.

local M = {
	treesitter_grammars = {},
	lsp_servers = {},
	formatters_by_ft = {},
	linters_by_ft = {},
}

function M.register(lang)
	if lang.treesitter then
		local grammars = type(lang.treesitter) == "table" and lang.treesitter or { lang.treesitter }
		vim.list_extend(M.treesitter_grammars, grammars)
	end

	if lang.lsp then
		table.insert(M.lsp_servers, lang.lsp)
	end

	if lang.formatter then
		for _, ft in ipairs(lang.filetypes) do
			M.formatters_by_ft[ft] = { lang.formatter }
		end
	end

	if lang.linter then
		for _, ft in ipairs(lang.filetypes) do
			M.linters_by_ft[ft] = { lang.linter }
		end
	end
end

return M
