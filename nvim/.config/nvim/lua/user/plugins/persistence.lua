return {
    "folke/persistence.nvim",
    config = function ()
        local persistence = require("persistence")
        persistence.setup()
        vim.api.nvim_create_user_command("SessionLoad", function ()
            persistence.load()
        end, {})
        vim.api.nvim_create_user_command("SessionLoadLast", function ()
            persistence.load({
                last = true
            })
        end, {})
    end
}

