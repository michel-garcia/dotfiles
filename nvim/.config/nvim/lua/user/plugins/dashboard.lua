return {
    "glepnir/dashboard-nvim",
    config = function ()
        local dashboard = require("dashboard")
        local version = vim.version()
        dashboard.custom_header = {
            "",
            "",
            "",
            " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
            " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
            " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
            " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
            " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
            " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
            "",
            string.format(
                "Version: %s.%s.%s",
                version.major,
                version.minor,
                version.patch
            ),
            "",
            ""
        }
        local button = function (desc, action)
            return {
                action = action,
                desc = desc
            }
        end
        dashboard.custom_center = {
            button("New File", ":enew"),
            button("Recent", ":FzfLua oldfiles"),
            button("Find", ":FzfLua files"),
            button("Config", function ()
                local ok, fzf = pcall(require, "fzf-lua")
                if not ok then
                    vim.cmd("edit ~/.config/nvim/lua")
                    return
                end
                fzf.files({
                    cwd = "~/.config/nvim/lua",
                    show_cwd_header = false
                })
            end),
            button("Quit", ":quit"),
        }
        dashboard.custom_footer = {
            "",
            "Most good programmers do programming not because they expect",
            "to get paid or get adulation by the public, but because it",
            "is fun to program.",
            "",
            "--- Linus Torvalds"
        }
        vim.cmd("hi DashboardHeader none")
        vim.cmd("hi link DashboardHeader @type")
        vim.cmd("hi DashboardFooter none")
        vim.cmd("hi link DashboardFooter @variable")
    end
}

