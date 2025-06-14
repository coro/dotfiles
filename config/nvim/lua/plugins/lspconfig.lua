return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			{
				"b0o/SchemaStore.nvim",
				version = false, -- last release is very old
			},
			{
				"williamboman/mason-lspconfig.nvim",
				-- NOTE: this is here because mason-lspconfig must install servers prior to running nvim-lspconfig
				lazy = false,
				dependencies = {
					{
						-- NOTE: this is here because mason.setup must run prior to running nvim-lspconfig
						-- see mason.lua for more settings.
						"williamboman/mason.nvim",
						lazy = false,
					},
				},
			},
			{
				"hrsh7th/nvim-cmp",
				-- NOTE: this is here because we get the default client capabilities from cmp_nvim_lsp
				-- see cmp.lua for more settings.
			},
			{
				"artemave/workspace-diagnostics.nvim",
				enabled = false,
			},
			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{
				"j-hui/fidget.nvim",
				enabled = false, -- TODO: figure out how this status shows without fidget
				opts = {},
			},
		},
		opts = {
			servers = {
				-- -- Example LSP settings below:
				-- lua_ls = {
				--   cmd = { ... },
				--   filetypes = { ... },
				--   capabilities = { ... },
				--   on_attach = { ... },
				--   settings = {
				--     Lua = {
				--       workspace = {
				--         checkThirdParty = false,
				--       },
				--       codeLens = {
				--         enable = true,
				--       },
				--       completion = {
				--         callSnippet = "Replace",
				--       },
				--     },
				--   },
				-- },
			},
		},
		config = function(_, opts)
			-- TODO: extend config with inspiration from
			-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua

			-- require("utils.diagnostics").setup_diagnostics()

			-- TODO: explain capabilities, see
			-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L526

			-- LSP servers and clients are able to communicate to each other what features they support.
			-- By default, Neovim doesn't support everything that is in the LSP Specification.
			-- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			-- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local client_capabilities = vim.lsp.protocol.make_client_capabilities()
			-- The nvim-cmp almost supports LSP's capabilities so you should advertise it to LSP servers..
			local completion_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capabilities = vim.tbl_deep_extend("force", client_capabilities, completion_capabilities)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, opts.servers[server] or {})

				-- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
				for _, v in pairs(server_opts) do
					if type(v) == "table" and v.workspace then
						v.workspace.didChangeWatchedFiles = {
							dynamicRegistration = false,
							relativePatternSupport = false,
						}
					end
				end

				-- Example settings for opts.servers[server]:
				--
				--   cmd = { ... },
				--   filetypes = { ... },
				--   capabilities = { ... },
				--   on_attach = { ... },
				--   settings = {
				--     Lua = {
				--       workspace = {
				--         checkThirdParty = false,
				--       },
				--       codeLens = {
				--         enable = true,
				--       },
				--       completion = {
				--         callSnippet = "Replace",
				--       },
				--     },
				--   }

				require("lspconfig")[server].setup(server_opts)
			end

			-- get all the servers that are available through mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig").get_mappings().lspconfig_to_package)
			end

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(opts.servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				-- automatically hook up LSPs which are Mason-installed but not explicitly set up with `opts.servers`
				mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
			end

			-- require("config.keymaps").setup_lsp_keymaps()

			-- vim.api.nvim_create_autocmd("LspAttach", {
			-- 	group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
			-- 	callback = function(event)
			-- 		require("config.keymaps").setup_lsp_autocmd_keymaps(event)
			-- 	end,
			-- })
		end,
	},
}
