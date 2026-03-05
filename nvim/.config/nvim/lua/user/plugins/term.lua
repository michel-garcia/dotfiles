local stack = {}

local spawn = function()
    local ergoterm = require("ergoterm")
    local terms = ergoterm.filter_by_tag("bottom")
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

return {
    "waiting-for-dev/ergoterm.nvim",
    config = function()
        local ergoterm = require("ergoterm")
        ergoterm.setup()
        vim.keymap.set({ "n", "t" }, "<C-\\>", function()
            local wins = vim.api.nvim_list_wins()
            for _, win in ipairs(wins) do
                local config = vim.api.nvim_win_get_config(win)
                if config.relative ~= "" then
                    return
                end
            end
            local count = vim.tbl_count(stack)
            local term = stack[count]
            if not term then
                spawn()
                return
            end
            term:toggle()
        end)
        local group = vim.api.nvim_create_augroup("ErgoTerm", {
            clear = true,
        })
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local opts = {
                    buffer = args.buf,
                }
                vim.keymap.set("t", "<C-t>", function()
                    spawn()
                end, opts)
                vim.keymap.set("t", "<C-x>", function()
                    local focused = ergoterm:get_focused()
                    if not focused then
                        return
                    end
                    focused:cleanup()
                    vim.schedule(function()
                        local count = vim.tbl_count(stack)
                        local term = stack[count]
                        if term then
                            term:focus()
                        end
                    end)
                end, opts)
                vim.keymap.set("t", "<C-g>", function()
                    ergoterm.select({
                        callbacks = {
                            default = {
                                desc = "Focus",
                                fn = function(selected)
                                    local terms = ergoterm.filter_by_tag("bottom")
                                    for _, term in ipairs(terms) do
                                        if term ~= selected then
                                            term:close()
                                        else
                                            term:focus()
                                        end
                                    end
                                end,
                            },
                            ["<C-w>"] = {
                                desc = "Kill",
                                fn = function(selected)
                                    selected:cleanup()
                                end,
                            },
                        },
                        prompt = "> ",
                    })
                end, opts)
                vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", opts)
            end,
            group = group,
            pattern = "ergoterm",
        })
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function(args)
                local term = ergoterm.find(function(term)
                    local buf = term:get_state("bufnr")
                    local integrated = vim.tbl_contains(term.tags, "bottom")
                    return buf == args.buf and integrated
                end)
                if term then
                    local count = vim.tbl_count(stack)
                    if stack[count] ~= term then
                        table.insert(stack, term)
                    end
                end
            end,
            group = group,
        })
        vim.api.nvim_create_autocmd("WinResized", {
            callback = function()
                local terms = ergoterm.filter_by_tag("bottom")
                for i, term in ipairs(terms) do
                    term:update({
                        name = string.format("Term %s", i),
                    })
                end
                for i, term in ipairs(stack) do
                    if not term:is_active() then
                        table.remove(stack, i)
                    end
                end
            end,
            group = group,
        })
    end,
}
