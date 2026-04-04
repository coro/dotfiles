vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

local lang = require("lib.language")

vim.lsp.enable(lang.lsp_servers)
vim.lsp.enable("stylua", false)
