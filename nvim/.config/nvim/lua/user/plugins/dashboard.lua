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
        local button = function (icon, desc, action)
            return {
                action = action,
                desc = string.format("%-50s", desc),
                icon = string.format("%s ", icon)
            }
        end
        dashboard.custom_center = {
            button("", "Recent", ":FzfLua oldfiles"),
            button("", "Find", ":FzfLua files"),
            button("", "Config", function ()
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
            button("", "Quit", ":quit"),
        }
        dashboard.custom_footer = {
            "",
            "Most good programmers do programming not because they expect",
            "to get paid or get adulation by the public, but because it",
            "is fun to program.",
            "",
            "--- Linus Torvalds"
        }
    end
}

