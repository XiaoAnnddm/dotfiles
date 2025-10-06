return {
    -- {
    --     "folke/tokyonight.nvim",
    --     config = function()
    --         vim.cmd.colorscheme "tokyonight"
    --         vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) --boundary
    --     end
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        cmd = function()
            require("catppuccin").setup({
                auto_integrations = true,
            })
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    }
}
