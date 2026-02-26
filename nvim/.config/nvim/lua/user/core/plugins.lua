local import

import = function(name, res, specs)
    local items = not vim.islist(res) and { res } or res
    vim.iter(items):each(function(item)
        local src = type(item) == "string" and item or item[1] or nil
        if not src or type(src) ~= "string" then
            local msg = table.concat({
                string.format("Failed to load: %s", name),
                "Missing source in spec",
            }, "\n")
            vim.notify(msg, vim.log.levels.ERROR)
            return
        end
        import(name, item.dependencies or {}, specs)
        table.insert(specs, {
            src = string.format("https://github.com/%s", src),
            data = {
                config = item.config,
            },
        })
    end)
end

local plugins_path = "user/plugins"
local pattern = string.format("lua/%s/**/*.lua", plugins_path)
local files = vim.api.nvim_get_runtime_file(pattern, true)
local specs = vim.iter(files):fold({}, function(specs, path)
    local name = vim.fn.fnamemodify(path, "%:t")
    local ok, res = pcall(dofile, path)
    if not ok or type(res) ~= "table" then
        local msg = table.concat({
            string.format("Failed to load: %s", name),
            res,
        }, "\n")
        vim.notify(msg, vim.log.levels.ERROR)
        return specs
    end
    import(name, res, specs)
    return specs
end)

vim.pack.add(specs, {
    confirm = false,
})

for _, spec in ipairs(specs) do
    if spec.data.config and vim.is_callable(spec.data.config) then
        spec.data.config()
    end
end
