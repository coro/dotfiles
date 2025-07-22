return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	cmd = {
		"Telescope",
	},
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("fzf")

		local keymap = vim.keymap
		keymap.set("n", "<leader>km", "<cmd>Telescope keymaps<cr>", { desc = "[k]ey[m]aps" })
		keymap.set("n", "<leader>lg", "<cmd>Telescope live_grep<cr>", { desc = "[l]ive [g]rep" })
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[f]ind [f]iles" })
	end,
}
