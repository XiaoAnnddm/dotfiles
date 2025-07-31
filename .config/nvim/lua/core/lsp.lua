vim.lsp.enable({
    'clangd',
    'lua-language-server',
})

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

        -- show return type
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            -- vim.lsp.inlay_hint.enable()
            vim.keymap.set('n', '<leader>th', function()
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
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end

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
