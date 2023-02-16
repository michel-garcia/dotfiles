return {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "awesome",
                    "beautiful",
                    "client",
                    "root",
                    "screen",
                    "vim"
                }
            },
            workspace = {
                library = {
                    vim.api.nvim_get_runtime_file("lua", true),
                    "/usr/share/awesome/lib"
                }
            }
        }
    }
}

