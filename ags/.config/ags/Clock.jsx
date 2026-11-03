import GLib from "gi://GLib";
import Gtk from "gi://Gtk?version=4.0";
import { createPoll } from "ags/time";

const Clock = ({ format = "%H:%M", interval = 1000 }) => {
    const time = createPoll("", interval, () => {
        return GLib.DateTime.new_now_local().format(format);
    });

    return (
        <menubutton>
            <label label={time} />
            <popover>
                <Gtk.Calendar class="calendar" />
            </popover>
        </menubutton>
    );
};

export default Clock;
