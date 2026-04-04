-- Generates lazy.nvim plugin specs for a language configuration.
--
-- Accepts a table with:
--   filetypes       (required) e.g. { "go" }
--   treesitter      (optional) grammar name, e.g. "go"
--   lsp             (optional) server name, e.g. "gopls"
--   formatter       (optional) string or { install = "...", name = "..." }
--   linter          (optional) string or { install = "...", name = "..." }

local function normalise_tool(tool)
	if type(tool) == "string" then
		return { install = tool, name = tool }
	end
	return { install = tool.install or tool.name, name = tool.name or tool.install }
end

local function extend_opts(key, values)
	return function(_, opts)
		opts[key] = opts[key] or {}
		vim.list_extend(opts[key], values)
	end
end

local function mason_install(name)
	return {
		"mason-org/mason.nvim",
		opts = extend_opts("mason_installations", { name }),
	}
end

return function(lang)
	local ft = lang.filetypes
	local specs = {}

	if lang.treesitter then
		local grammars = type(lang.treesitter) == "table" and lang.treesitter or { lang.treesitter }
		specs[#specs + 1] = {
			"nvim-treesitter/nvim-treesitter",
			ft = ft,
			opts = extend_opts("ensure_installed", grammars),
		}
	end

	if lang.lsp then
		specs[#specs + 1] = {
			"mason-org/mason-lspconfig.nvim",
			ft = ft,
			opts = extend_opts("ensure_installed", { lang.lsp }),
		}
	end

	if lang.formatter then
		local f = normalise_tool(lang.formatter)
		local ft_map = {}
		for _, t in ipairs(ft) do
			ft_map[t] = { f.name }
		end
		specs[#specs + 1] = {
			"stevearc/conform.nvim",
			ft = ft,
			dependencies = { mason_install(f.install) },
			opts = { formatters_by_ft = ft_map },
		}
	end

	if lang.linter then
		local l = normalise_tool(lang.linter)
		local ft_map = {}
		for _, t in ipairs(ft) do
			ft_map[t] = { l.name }
		end
		specs[#specs + 1] = {
			"mfussenegger/nvim-lint",
			ft = ft,
			dependencies = { mason_install(l.install) },
			opts = { linters_by_ft = ft_map },
		}
	end

	return specs
end
