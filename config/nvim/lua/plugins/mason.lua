return {

	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
	config = function(_, opts)
		require("mason").setup(opts)

		-- handle opts.ensure_installed
		local registry = require("mason-registry")
		registry.refresh(function()
			for _, pkg_name in ipairs(opts.ensure_installed) do
				local pkg = registry.get_package(pkg_name)
				if not pkg:is_installed() then
					pkg:install()
				end
			end
		end)
	end,
}
