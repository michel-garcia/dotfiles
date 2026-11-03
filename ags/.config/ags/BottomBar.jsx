import Astal from "gi://Astal?version=4.0";
import { onCleanup } from "ags";
import app from "ags/gtk4/app";

import Cpu from "./Cpu";
import Drive from "./Drive";
import Memory from "./Memory";
import Windows from "./Windows";

const BottomBar = ({ gdkmonitor }) => {
    let win = null;

    onCleanup(() => {
        win.destroy();
    });

    return (
        <window
            $={(self) => (win = self)}
            anchor={
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.BOTTOM |
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
                    <Windows gdkmonitor={gdkmonitor} />
                </box>
                <box $type="end" spacing={6}>
                    <Drive />
                    <Cpu />
                    <Memory />
                </box>
            </centerbox>
        </window>
    );
};

export default BottomBar;
