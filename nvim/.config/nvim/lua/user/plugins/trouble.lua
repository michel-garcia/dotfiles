return {
    "folke/trouble.nvim",
    config = function()
        local trouble = require("trouble")
        trouble.setup({
            icons = false,
            mode = "document_diagnostics",
            use_diagnostics_signs = true,
        })
    end,
}
