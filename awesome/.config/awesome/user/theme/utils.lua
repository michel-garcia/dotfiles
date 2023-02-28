local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")

local function get_icon(name, size)
    local theme = Gtk.IconTheme.get_default()
    local info = theme:lookup_icon(name, size or 24, 0)
    if info then
        local path = info:get_filename()
        return path
    end
end

return {
    get_icon = get_icon
}

