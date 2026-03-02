return {
    "waiting-for-dev/ergoterm.nvim",
    config = function()
        local ergoterm = require("ergoterm")
        ergoterm.setup()
        local pick = function()
            ergoterm.select({
                default = {
                    fn = function(selected)
                        local terms = ergoterm:get_all()
                        for _, term in ipairs(terms) do
                            if term ~= selected then
                                term:close()
                            else
                                term:focus()
                            end
                        end
                    end,
                },
            })
        end
        local spawn = function()
            local terms = ergoterm:get_all()
            for _, term in ipairs(terms) do
                term:close()
            end
            local count = vim.tbl_count(terms)
            local term = ergoterm:new({
                border = "single",
                name = string.format("Term %s", count + 1),
                size = {
                    below = 12,
                },
                tags = { "bottom" },
            })
            term:focus()
        end
        vim.keymap.set("n", "<leader>tt", function()
            pick()
        end)
        vim.keymap.set({ "n", "t" }, "<C-\\>", function()
            local last = ergoterm.get_state("last_focused")
            if last then
                last:toggle()
                return
            end
            spawn()
        end)
        vim.keymap.set({ "n", "t" }, "<C-t>", function()
            spawn()
        end)
        vim.keymap.set("t", "<C-f>", function()
            pick()
        end)
        vim.keymap.set("t", "<C-x>", function()
            local term = ergoterm:get_focused()
            if term then
                term:cleanup()
            end
        end)
        vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>")
    end,
}
