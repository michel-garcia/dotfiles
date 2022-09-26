return {
    "rest-nvim/rest.nvim",
    requires = {
        "nvim-lua/plenary.nvim"
    },
    config = function ()
        local rest = require("rest-nvim")
        rest.setup({
            result = {
                formatters = {
                    json = "jq"
                },
                show_headers = true,
                show_http_info = true,
                show_url = true
            },
            result_split_horizontal = false,
            skip_ssl_verification = true
        })
        vim.api.nvim_create_user_command("Rest", function ()
            rest.run()
        end, {})
    end
}

