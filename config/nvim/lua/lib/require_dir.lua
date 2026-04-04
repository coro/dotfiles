-- Requires all .lua files in a directory under lua/, in alphabetical order.
return function(dir)
	local path = vim.fn.stdpath("config") .. "/lua/" .. dir:gsub("%.", "/")
	local files = {}
	for name, type in vim.fs.dir(path) do
		if type == "file" and name:match("%.lua$") then
			files[#files + 1] = name
		end
	end
	table.sort(files)
	for _, name in ipairs(files) do
		require(dir .. "." .. name:gsub("%.lua$", ""))
	end
end
