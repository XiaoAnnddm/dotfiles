vim.g.mapleader = ' '
vim.g.localleader = ' '

vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>wq", ":wq<CR>")

vim.keymap.set("n", "<leader>lz", ":Lazy<CR>")
vim.keymap.set("n", "<leader>tt", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tn", ":tabNext<CR>")
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>")

-- V
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
