return {
    "rest-nvim/rest.nvim",
    dependencies = {
        {
            "vhyrro/luarocks.nvim",
            config = true,
            opts = {
                rocks = {
                    "lua-curl", "nvim-nio", "mimetypes", "xml2lua"
                }
            }
        }
    },
    config = true,
    ft = "http",
    main = "rest-nvim",
    opts = {
        skip_ssl_verification  = true
    }
}
