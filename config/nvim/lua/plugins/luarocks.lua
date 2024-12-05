return {
	"vhyrro/luarocks.nvim",
	priority = 999, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
	opts = {
		rocks = { "tiktoken_core" }, -- specifies a list of rocks to install
	},
}
