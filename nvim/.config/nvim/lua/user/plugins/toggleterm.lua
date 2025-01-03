return {
    "akinsho/toggleterm.nvim",
    config = function()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
            persist_mode = false,
            shade_terminals = false,
            size = 15,
        })
        for n = 1, 9 do
            local kopts = {
                noremap = true,
                silent = true,
            }
            vim.keymap.set({ "n", "t" }, string.format("<A-%s>", n), function()
                local instances = require("toggleterm.terminal")
                local terminals = instances.get_all()
                for _, terminal in ipairs(terminals) do
                    if terminal.id ~= n then
                        terminal:close()
                    end
                end
                toggleterm.toggle(n)
            end, kopts)
        end
    end,
}
