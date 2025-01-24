local M = {}

function M.load_modules_in_directory(directory)
	-- Get the runtime path where Neovim looks for files
	local runtime_path = vim.fn.stdpath("config") .. "/lua/" .. directory

	for file in vim.fs.dir(runtime_path) do
		if file:match("%.lua$") then
			-- Remove .lua extension and convert / to .
			local module_name = directory .. "." .. file:gsub("%.lua$", "")
			require(module_name)
		end
	end
end

return M
