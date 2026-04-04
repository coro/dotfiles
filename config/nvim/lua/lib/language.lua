-- Shared language registry.
-- Language files call M.register() to declare their tools.
-- Plugin setup files read from the collected tables.

local M = {
	treesitter_grammars = {},
	lsp_servers = {},
	formatters_by_ft = {},
	linters_by_ft = {},
}

local function normalise_tool(tool)
	if type(tool) == "string" then
		return tool
	end
	return tool.name or tool.install
end

function M.register(lang)
	if lang.treesitter then
		local grammars = type(lang.treesitter) == "table" and lang.treesitter or { lang.treesitter }
		vim.list_extend(M.treesitter_grammars, grammars)
	end

	if lang.lsp then
		table.insert(M.lsp_servers, lang.lsp)
	end

	if lang.formatter then
		local name = normalise_tool(lang.formatter)
		for _, ft in ipairs(lang.filetypes) do
			M.formatters_by_ft[ft] = { name }
		end
	end

	if lang.linter then
		local name = normalise_tool(lang.linter)
		for _, ft in ipairs(lang.filetypes) do
			M.linters_by_ft[ft] = { name }
		end
	end
end

return M
