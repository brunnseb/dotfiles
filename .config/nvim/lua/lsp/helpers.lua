local M = {}

function M.compose_root_dir(pattern, filename)
	local lspconfig = require("lspconfig")
	local root
	-- in order of preference:
	-- * git repository root
	-- * pattern
	-- * package.json root
	-- * node_modules root
	root = lspconfig.util.find_git_ancestor(filename)
	root = root or lspconfig.util.root_pattern(unpack(pattern))(filename)
	root = root or lspconfig.util.find_package_json_ancestor(filename)
	root = root or lspconfig.util.find_node_modules_ancestor("tsconfig.json")(filename)
	return root
end

return M
