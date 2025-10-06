vim.lsp.enable({
    'clangd',
    'lua-language-server',
    'glsl',
    'qmlls',
})

-- cmp window border
vim.o.winborder = 'rounded'

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

        -- hover highlight update time
        vim.opt_local.updatetime = 1000

        -- [keymaps]
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
            { buffer = event.buf, desc = 'LSP: Goto Definition' })

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
            { buffer = event.buf, desc = 'LSP: Goto Declaration' })

        -- [warning message show in line]
        vim.diagnostic.config {
            virtual_text = true,
        }

        -- show more warning
        vim.keymap.set('n', '<leader>lw', function()
            vim.diagnostic.open_float { source = true }
        end, { buffer = event.buf, desc = 'LSP: Show Diagnostic' })

        -- hide warning
        vim.keymap.set(
            'n',
            '<leader>tw',
            (function()
                local diag_status = 1 -- 1 is show; 0 is hide
                return function()
                    if diag_status == 1 then
                        diag_status = 0
                        vim.diagnostic.config { underline = false, virtual_text = false, signs = false, update_in_insert = false }
                    else
                        diag_status = 1
                        vim.diagnostic.config { underline = true, virtual_text = true, signs = true, update_in_insert = true }
                    end
                end
            end)(),
            { buffer = event.buf, desc = 'LSP: Toggle Diagnostics' }
        )

        -- show return type
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            -- vim.lsp.inlay_hint.enable()
            vim.keymap.set('n', '<leader>lt', function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { buffer = event.buf, desc = 'LSP: Toggle Inlay Hints' })
        end

        -- highlight
        if client and client.supports_method(
                vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup(
                'kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        -- if client:supports_method('textDocument/completion') then
        --     -- Optional: trigger autocompletion on EVERY keypress. May be slow!
        --     -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
        --     -- client.server_capabilities.completionProvider.triggerCharacters = chars
        --     vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        -- end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
