-- lua_ls takes a long time to load, resulting in an annoying flickering of colours when the semantic
-- tokens kick in.
vim.hl.priorities.semantic_tokens = 95
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "lua" })
		end,
		ft = { "lua" },
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "lua_ls" })
		end,
		ft = { "lua" },
	},
	{
		"stevearc/conform.nvim",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = function(_, opts)
					opts.mason_installations = opts.mason_installations or {}
					vim.list_extend(opts.mason_installations, { "stylua" })
				end,
			},
		},
		ft = { "lua" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = function(_, opts)
					opts.mason_installations = opts.mason_installations or {}
					vim.list_extend(opts.mason_installations, { "luacheck" })
				end,
			},
		},
		ft = { "lua" },
		opts = {
			linters_by_ft = {
				lua = { "luacheck" },
			},
		},
	},
}
