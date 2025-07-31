return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
	local builtin = require('telescope.builtin')
	vim.keymap.set(
	    'n', '<leader>ff', 
	    builtin.find_files, 
	    { desc = 'Telescope find files' })
	-- fg按内容查找
	vim.keymap.set(
	    'n', '<leader>fg', 
	    builtin.live_grep, 
	    { desc = 'Telescope live grep' })
	-- fb按buffer内容查找
	vim.keymap.set(
	    'n', '<leader>fb', 
	    builtin.buffers, 
	    { desc = 'Telescope buffers' })
	-- fh查看帮助手册
	vim.keymap.set(
	    'n', '<leader>fh', 
	    builtin.help_tags, 
	    { desc = 'Telescope help tags' })
	
	vim.keymap.set(
	    'n', '<leader>fo',
	    builtin.oldfiles,
	    { desc = 'Telescope oldfiles'})
    end
}
