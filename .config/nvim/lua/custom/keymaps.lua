vim.g.mapleader = ' '
vim.g.localleader = ' '

-- quit
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>wq", ":wq<CR>")

-- write
vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

vim.keymap.set("n", "<leader>lz", ":Lazy<CR>")
