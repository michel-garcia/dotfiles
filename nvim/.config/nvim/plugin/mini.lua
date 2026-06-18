vim.pack.add({
    "https://github.com/nvim-mini/mini.cmdline",
    "https://github.com/nvim-mini/mini.completion",
    "https://github.com/nvim-mini/mini.ai",
    "https://github.com/nvim-mini/mini.cursorword",
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/nvim-mini/mini.jump",
    "https://github.com/nvim-mini/mini.surround",
    "https://github.com/nvim-mini/mini.splitjoin",
})

local cmdline = require("mini.cmdline")
cmdline.setup({
    autopeek = {
        enable = false,
    },
})

local completion = require("mini.completion")
completion.setup({
    delay = {
        completion = 0,
        info = 0,
        signature = 0,
    },
    window = {
        signature = {
            border = "solid",
        },
    },
})
vim.api.nvim_create_autocmd("User", {
    callback = function(args)
        local config = vim.api.nvim_win_get_config(args.data.win_id)
        config.title = ""
        vim.api.nvim_win_set_config(args.data.win_id, config)
    end,
    pattern = "MiniCompletionWindowOpen",
    group = vim.api.nvim_create_augroup("MiniCompletionCustomization", {
        clear = true,
    }),
})

local ai = require("mini.ai")
ai.setup()

local cursorword = require("mini.cursorword")
cursorword.setup({
    delay = 0,
})

local icons = require("mini.icons")
icons.setup()
icons.tweak_lsp_kind()

local jump = require("mini.jump")
jump.setup()

local surround = require("mini.surround")
surround.setup()

local splitjoin = require("mini.splitjoin")
splitjoin.setup()
