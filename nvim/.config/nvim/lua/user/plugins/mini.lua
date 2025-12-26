return {
    {
        "nvim-mini/mini.completion",
        opts = {
            delay = {
                completion = 0,
                info = 0,
                signature = 0,
            },
            window = {
                info = {
                    border = "solid",
                },
                signature = {
                    border = "solid",
                },
            },
        },
    },
    {
        "nvim-mini/mini.ai",
        config = true,
    },
    {
        "nvim-mini/mini.cursorword",
        opts = {
            delay = 0,
        },
    },
    {
        "nvim-mini/mini.icons",
        config = function()
            local icons = require("mini.icons")
            icons.setup()
            icons.tweak_lsp_kind()
        end,
    },
    {
        "nvim-mini/mini.jump",
        config = true,
    },
    {
        "nvim-mini/mini.surround",
        config = true,
    },
    {
        "nvim-mini/mini.splitjoin",
        config = true,
    },
}
