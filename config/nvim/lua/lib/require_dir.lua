-- Requires all .lua files in a directory under lua/.
return function(dir)
	local path = vim.fn.stdpath("config") .. "/lua/" .. dir:gsub("%.", "/")
	for name, type in vim.fs.dir(path) do
		if type == "file" and name:match("%.lua$") then
			require(dir .. "." .. name:gsub("%.lua$", ""))
		end
	end
end
