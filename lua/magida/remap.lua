vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>dt', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation)
