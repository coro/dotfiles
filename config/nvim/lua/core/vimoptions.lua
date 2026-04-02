-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 25
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Default indent to 2 spaces (vim-sleuth overrides per-file when detected)
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Take advantage of the nvim 0.11 diagnostics options
vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true

  -- Alternatively, customize specific options
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
})

-- Prettier popups
vim.o.winborder = "rounded"
