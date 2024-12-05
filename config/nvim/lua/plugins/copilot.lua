local function enable_copilot()
	if vim.fn.executable("node") == 1 then
		return true
	else
		vim.notify("Node is not available, but required for Copilot.", vim.log.levels.WARN)
		return false
	end
end

return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			{ "hrsh7th/nvim-cmp" },
			{
				"nvim-lualine/lualine.nvim",
				event = "VeryLazy",
				opts = function(_, opts)
					local function codepilot()
						local icon = require("utils.defaults").icons.kinds.Copilot
						return icon
					end

					opts.copilot = {
						lualine_component = {
							codepilot,
						},
					}
				end,
			},
		},
		enabled = enable_copilot(),
		cmd = "Copilot",
		event = "InsertEnter",
		build = ":Copilot auth",
		opts = {
			panel = {
				enabled = true,
				auto_refresh = true,
			},
			suggestion = {
				enabled = true,
				-- use the built-in keymapping for "accept" (<M-l>)
				auto_trigger = true,
				accept = false, -- disable built-in keymapping
			},
			filetypes = {
				yaml = true,
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)

			-- hide copilot suggestions when cmp menu is open
			-- to prevent odd behavior/garbled up suggestions
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				cmp.event:on("menu_opened", function()
					vim.b.copilot_suggestion_hidden = true
				end)

				cmp.event:on("menu_closed", function()
					vim.b.copilot_suggestion_hidden = false
				end)
			end
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		enabled = enable_copilot(),
		branch = "canary", -- while in development
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			debug = false, -- Enable debugging
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
			require("CopilotChat.integrations.cmp").setup()
		end,
	},
}
