function is_git_dir()
    local job_id = vim.fn.jobstart({ "git", "rev-parse", "--git-dir" })
    return vim.fn.jobwait({ job_id })[1] == 0
end

return {
    "lewis6991/gitsigns.nvim",
    config = function ()
        if not is_git_dir() then
            vim.env.GIT_DIR = vim.fn.expand("~/.dotfiles")
            vim.env.GIT_WORK_TREE = vim.fn.expand("~")
        end
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            current_line_blame = false,
            signcolumn = true
        })
    end
}

