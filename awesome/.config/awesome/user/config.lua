return {
    apps = {
        editor = os.getenv("EDITOR") or "nvim",
        terminal = os.getenv("TERMINAL") or "kitty"
    },
    keys = {
        mod = "Mod4"
    },
    startup = {
        "nitrogen --restore"
    }
}

