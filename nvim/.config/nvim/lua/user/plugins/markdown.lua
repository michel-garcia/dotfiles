return {
    "iamcco/markdown-preview.nvim",
    build = function ()
        local markdown = {
            install = vim.fn["mkdp#util#install"]
        }
        markdown.install()
    end,
    event = "BufRead"
}

