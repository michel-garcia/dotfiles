import Astal from "gi://Astal?version=4.0";
import { onCleanup } from "ags";
import app from "ags/gtk4/app";

import Battery from "./Battery";
import Clock from "./Clock";
import Tray from "./Tray";
import Volume from "./Volume";
import Workspaces from "./Workspaces";

const TopBar = ({ gdkmonitor }) => {
    let win = null;

    onCleanup(() => {
        win.destroy();
    });

    return (
        <window
            $={(self) => (win = self)}
            anchor={
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.TOP |
                Astal.WindowAnchor.RIGHT
            }
            application={app}
            class="bar"
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            gdkmonitor={gdkmonitor}
            visible
        >
            <centerbox>
                <box $type="start" spacing={6}>
                    <Workspaces gdkmonitor={gdkmonitor} />
                </box>
                <box $type="center" spacing={6}>
                    <Clock format="%a %b %d %H:%M:%S" />
                </box>
                <box $type="end" spacing={6}>
                    <Tray />
                    <Volume />
                    <Battery />
                </box>
            </centerbox>
        </window>
    );
};

export default TopBar;
