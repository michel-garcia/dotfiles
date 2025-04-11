return {
    "iamcco/markdown-preview.nvim",
    event = "BufRead",
    build = function()
        local markdown = {
            install = vim.fn["mkdp#util#install"],
        }
        markdown.install()
    end,
}
