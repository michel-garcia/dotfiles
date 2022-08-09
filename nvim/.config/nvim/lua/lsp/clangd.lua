local root_files = {
    ".ccls",
    ".git",
    "Makefile"
}

local function find_root()
end

return {
    root_dir = function (filename)
        find_root()
    end
}
