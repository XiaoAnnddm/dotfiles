return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    event = { 'BufReadPost', 'BufNewFile' },
    -- use a release tag to download pre-built binaries
    version = '1.*',

    opts = {
        completion = {
            documentation = {
                auto_show = true,
            },
        },
        signature = {
            enabled = true,
        },
        cmdline = {
            completion = {
                menu = {
                    --auto_show = true,
                },
            },
        },
        keymap = {
            ['<C-h>'] = {
                function(cmp) cmp.accept({ index = 1 }) end
            },
        }
        -- sources = {
        --     providers = {
        --         snippets = { score_offset = 1000 },
        --     },
        -- },
    },

}
