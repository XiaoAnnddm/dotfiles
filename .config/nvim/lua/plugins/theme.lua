return {
    {
	    "folke/tokyonight.nvim",
	    config = function()
	        vim.cmd.colorscheme "tokyonight"
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })   --boundary
	    end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    }
}

