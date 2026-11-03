import GLib from "gi://GLib";
import { createPoll } from "ags/time";

const Memory = ({ interval = 1000 }) => {
    const data = createPoll([0, 0], interval, () => {
        try {
            const [, contents] = GLib.file_get_contents("/proc/meminfo");
            const info = new TextDecoder().decode(contents);
            const get = (key) =>
                Number(info.match(new RegExp(`${key}:\\s+(\\d+)`))?.[1] || 0) *
                1024;
            const total = get("MemTotal");
            const available = get("MemAvailable");
            const used = total - available;
            return [used / 1024 ** 3, total / 1024 ** 3];
        } catch {
            return [0, 0];
        }
    });

    return (
        <box>
            <label
                label={data(
                    ([used, total]) =>
                        `RAM: ${used.toFixed(1)}/${total.toFixed(1)}G`,
                )}
            />
        </box>
    );
};

export default Memory;
