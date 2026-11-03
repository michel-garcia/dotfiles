import GLib from "gi://GLib";
import { createPoll } from "ags/time";

const Drive = ({ interval = 10000 }) => {
    const data = createPoll([0, 0], interval, () => {
        try {
            let [success, stdout] = GLib.spawn_command_line_sync("df -B1 /");
            if (!success) {
                return [0, 0];
            }
            let output = new TextDecoder().decode(stdout).trim();
            let lines = output.split("\n");
            if (lines.length < 2) {
                return [0, 0];
            }
            let parts = lines[1].trim().split(/\s+/);
            let used = parseInt(parts[2]) || 0;
            let total = parseInt(parts[1]) || 0;
            const factor = Math.pow(1024, 3);
            return [used / factor, total / factor];
        } catch (e) {
            return [0, 0];
        }
    });

    return (
        <box>
            <label
                label={data(
                    ([used, total]) =>
                        `DRV: ${used.toFixed(1)}/${total.toFixed(1)}G`,
                )}
            />
        </box>
    );
};

export default Drive;
