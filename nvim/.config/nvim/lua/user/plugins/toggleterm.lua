return {
    "akinsho/toggleterm.nvim",
    opts = {
        persist_mode = false,
        shade_terminals = false,
    },
    config = function(_, opts)
        local toggleterm = require("toggleterm")
        toggleterm.setup(opts)
        local instances = require("toggleterm.terminal")
        for id = 1, 9 do
            vim.keymap.set({ "n", "t" }, string.format("<C-%s>", id), function()
                local terminals = instances.get_all()
                for _, terminal in ipairs(terminals) do
                    if terminal.id ~= id then
                        terminal:close()
                    end
                end
                toggleterm.toggle(id)
                vim.schedule(function()
                    local type = vim.api.nvim_get_option_value("buftype", {})
                    if type == "terminal" then
                        vim.cmd("startinsert")
                    end
                end)
            end, {
                noremap = true,
                silent = true,
            })
        end
    end,
}
