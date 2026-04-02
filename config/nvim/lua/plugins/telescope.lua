return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	cmd = { "Telescope" },
	keys = {
		{ "<leader>km", "<cmd>Telescope keymaps<cr>", desc = "[k]ey[m]aps" },
		{ "<leader>lg", "<cmd>Telescope live_grep<cr>", desc = "[l]ive [g]rep" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[f]ind [f]iles" },
	},
	opts = {
		extensions = { fzf = {} },
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
	end,
}
