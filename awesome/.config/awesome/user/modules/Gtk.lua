local lgi = require("lgi")
local IconTheme = lgi.require("Gtk", "3.0").IconTheme

local theme = IconTheme.get_default()

local Gtk = {}

Gtk.get_example_icon_name = function ()
    local name = theme:get_example_icon_name()
    return Gtk.lookup_icon(name)
end

Gtk.get_search_path = function ()
    local path = nil
    theme:get_search_path(path);
    return path
end

Gtk.lookup_icon = function (name, size)
    local info = theme:lookup_icon(name, size or 24, 0)
    if not info then
        return
    end
    return info:get_filename()
end

return Gtk
