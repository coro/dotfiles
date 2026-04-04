vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

local telescope = require("telescope")
telescope.setup({ extensions = { fzf = {} } })
telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>km", "<cmd>Telescope keymaps<cr>", { desc = "[k]ey[m]aps" })
vim.keymap.set("n", "<leader>lg", "<cmd>Telescope live_grep<cr>", { desc = "[l]ive [g]rep" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[f]ind [f]iles" })
