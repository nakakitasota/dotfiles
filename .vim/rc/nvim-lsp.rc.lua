vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Attach key mappings for LSP functionalities",
    callback = function ()
        vim.keymap.set('n', '[LSP]', '<Nop>')
        vim.keymap.set('n', '<Space>l', '[LSP]', {remap = true})

        vim.keymap.set('n', '[LSP]r', '<cmd>lua vim.lsp.buf.rename()<CR>')
        vim.keymap.set('n', '[LSP]a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
        vim.keymap.set('n', '[LSP]f',     '<cmd>lua vim.lsp.buf.formatting()<CR>')
        vim.keymap.set('n', 'K',      '<cmd>lua vim.lsp.buf.hover()<CR>')
        vim.keymap.set('n', 'gr',     '<cmd>lua vim.lsp.buf.references()<CR>')
        vim.keymap.set('n', 'gd',     '<cmd>lua vim.lsp.buf.definition()<CR>')
        vim.keymap.set('n', 'gD',     '<cmd>lua vim.lsp.buf.declaration()<CR>')
        vim.keymap.set('n', 'gi',     '<cmd>lua vim.lsp.buf.implementation()<CR>')
        vim.keymap.set('n', 'gt',     '<cmd>lua vim.lsp.buf.type_definition()<CR>')
        vim.keymap.set('n', 'ge',     '<cmd>lua vim.diagnostic.open_float()<CR>')
        vim.keymap.set('n', 'g]',     '<cmd>lua vim.diagnostic.goto_next()<CR>')
        vim.keymap.set('n', 'g[',     '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    end
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "single"
    }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signatureHelp, {
        border = "single"
    }
)
vim.diagnostic.config({ float = { border = "single" } })

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "▶︎",
            [vim.diagnostic.severity.WARN]  = "▶︎",
            [vim.diagnostic.severity.INFO]  = "▶︎",
            [vim.diagnostic.severity.HINT]  = "▶︎",
        },
    },
})
