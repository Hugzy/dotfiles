return {
    "FabijanZulj/blame.nvim",
    config = function()
        require("blame").setup()
        vim.keymap.set('n', '<leader>c', "<cmd>BlameToggle<CR>")
    end
}
