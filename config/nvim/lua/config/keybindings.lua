vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[g]o to [d]efinition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[g]o to [r]eferences" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame object" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Contextual code actions" })
