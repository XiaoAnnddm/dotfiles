-- Nerd字体
vim.g.have_nerd_font = true

-------------------- vim.opt --------------------
-- 行号
vim.opt.number = true

-- 光标
vim.opt.mouse = 'a'
vim.opt.cursorline = true

vim.opt.relativenumber = true -- 行号
vim.opt.shiftwidth = 4        -- tab缩进
vim.opt.tabstop = 4

-- 显示空白字符
vim.opt.list = true
vim.opt.listchars = { tab = '→ ', space = '·', trail = '·' }

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true


vim.opt.clipboard:append("unnamedplus")

vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.wrap = false


-- 操作记录
vim.opt.undofile = true
