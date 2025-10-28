---@type vim.lsp.Config

-- local function get_typescript_server_path(root_dir)
-- 	local tsdk = vim.fn.glob(root_dir .. '/node_modules/typescript/lib')
-- 	if vim.fn.isdirectory(tsdk) == 1 then
-- 		return tsdk
-- 	end
-- 	return nil
-- end

return {
	cmd = { 'astro-ls', '--stdio' },
	filetypes = { 'astro' },
	root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
	init_options = {
		typescript = {
			-- tsdk = get_typescript_server_path(vim.fs.root(0, { 'package.json' }))
			-- 	or (vim.fn.getcwd() .. '/node_modules/typescript/lib'),
			tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
		},
	},
	-- before_init = function(_, config)
	-- 	if config.init_options and
	-- 		config.init_options.typescript and
	-- 		not config.init_options.typescript.tsdk
	-- 	then
	-- 		config.init_options.typescript.tsdk = get_typescript_server_path(config.root_dir)
	-- 	end
	-- end,
}
