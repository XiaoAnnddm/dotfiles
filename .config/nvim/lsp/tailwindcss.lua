---@brief
--- https://github.com/tailwindlabs/tailwindcss-intellisense
---
--- Tailwind CSS Language Server can be installed via npm:
---
--- npm install -g @tailwindcss/language-server

-- 自己实现 util 工具函数
local util = {}

-- 获取有效的制表符大小
function util.get_effective_tabstop()
	return vim.bo.tabstop or 2
end

-- 向列表中插入 package.json 的依赖字段
function util.insert_package_json(root_files, field, fname)
	local result = vim.deepcopy(root_files)
	table.insert(result, 'package.json')
	return result
end

-- 根据字段查找根标记（这个比较复杂，简化版本）
function util.root_markers_with_field(root_files, markers, field, fname)
	local result = vim.deepcopy(root_files)
	for _, marker in ipairs(markers) do
		table.insert(result, marker)
	end
	return result
end

---@type vim.lsp.Config
return {
	cmd = { 'tailwindcss-language-server', '--stdio' },
	filetypes = {
		'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure',
		'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs',
		'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs',
		'html', 'htmlangular', 'html-eex', 'heex', 'jade', 'leaf', 'liquid',
		'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor',
		'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus',
		'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript',
		'typescript', 'typescriptreact', 'vue', 'svelte', 'templ',
	},
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = 'warning',
				invalidApply = 'error',
				invalidScreen = 'error',
				invalidVariant = 'error',
				invalidConfigPath = 'error',
				invalidTailwindDirective = 'error',
				recommendedVariantOrder = 'warning',
			},
			classAttributes = {
				'class',
				'className',
				'class:list',
				'classList',
				'ngClass',
			},
			includeLanguages = {
				eelixir = 'html-eex',
				elixir = 'phoenix-heex',
				eruby = 'erb',
				heex = 'phoenix-heex',
				htmlangular = 'html',
				templ = 'html',
			},
		},
	},
	before_init = function(_, config)
		if not config.settings then
			config.settings = {}
		end
		if not config.settings.editor then
			config.settings.editor = {}
		end
		if not config.settings.editor.tabSize then
			config.settings.editor.tabSize = util.get_effective_tabstop()
		end
	end,
	workspace_required = true,
	root_dir = function(bufnr)
		local root_files = {
			'tailwind.config.js',
			'tailwind.config.cjs',
			'tailwind.config.mjs',
			'tailwind.config.ts',
			'postcss.config.js',
			'postcss.config.cjs',
			'postcss.config.mjs',
			'postcss.config.ts',
			'theme/static_src/tailwind.config.js',
			'theme/static_src/tailwind.config.cjs',
			'theme/static_src/tailwind.config.mjs',
			'theme/static_src/tailwind.config.ts',
			'theme/static_src/postcss.config.js',
			'package.json',
			'mix.lock',
			'Gemfile.lock',
			'.git',
		}
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local found = vim.fs.find(root_files, { path = vim.fs.dirname(fname), upward = true })
		if found[1] then
			return vim.fs.dirname(found[1])
		end
		return nil
	end,
}
