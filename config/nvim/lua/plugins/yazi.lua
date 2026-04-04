vim.pack.add({ "https://github.com/mikavilpas/yazi.nvim" })

vim.g.loaded_netrwPlugin = 1

require("yazi").setup({
	open_for_directories = true,
	keymaps = {
		show_help = "<f1>",
	},
})

vim.keymap.set({ "n", "v" }, "<leader>t", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
vim.keymap.set("n", "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })
