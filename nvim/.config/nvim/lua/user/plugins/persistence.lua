return {
    "folke/persistence.nvim",
    config = function ()
        local persistence = require("persistence")
        persistence.setup()
        vim.api.nvim_create_user_command("PersistenceLoad", function ()
            persistence.load()
        end, {})
        vim.api.nvim_create_user_command("PersistenceLoadLast", function ()
            persistence.load({
                last = true
            })
        end, {})
        vim.api.nvim_create_user_command("PersistenceList", function ()
            local paths = {}
            local fzf = require("fzf-lua")
            fzf.fzf_exec(function (callback)
                    paths = {}
                    for _, path in ipairs(persistence.list()) do
                        local filename = vim.fn.fnamemodify(path, ":t:r")
                        local name = filename:gsub("%%", "/")
                        paths[name] = path
                        callback(name)
                    end
                    callback()
                end, {
                actions = {
                    ["default"] = function (selected)
                        local path = vim.fn.fnameescape(paths[selected[1]])
                        if vim.fn.exists(path) then
                            vim.cmd.source(path)
                        end
                    end,
                    ["ctrl-x"] = function (selected)
                        local path = paths[selected[1]]
                        vim.fn.delete(path)
                        fzf.resume()
                    end
                }
            })
        end, {})
    end
}

