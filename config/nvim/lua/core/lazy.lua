-- Function to check if a directory exists
local function directory_exists(path)
	return (vim.uv or vim.loop).fs_stat(path) ~= nil
end

-- Function to clone the lazy.nvim repository
local function clone_lazy_nvim(repo_url, destination)
	local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo_url, destination })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ result, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- Path where lazy.nvim will be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed, if not, clone it from GitHub
if not directory_exists(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	clone_lazy_nvim(lazyrepo, lazypath)
end

-- Prepend the lazy.nvim path to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Set up global leader keys before loading lazy.nvim
vim.g.mapleader = " " -- Space key as the leader key
vim.g.maplocalleader = "\\" -- Backslash key as the local leader key

-- Load and configure lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" }, -- Import plugin configurations
		{ import = "languages" }, -- Import language-specific configurations
	},
	checker = { enabled = false }, -- Disable automatic plugin update checks
})
