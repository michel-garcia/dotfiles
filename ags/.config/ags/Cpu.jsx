import GLib from "gi://GLib";
import { createPoll } from "ags/time";

const Cpu = ({ interval = 1000 }) => {
    let prev = {
        idle: 0,
        total: 0,
    };

    const data = createPoll(0, interval, () => {
        try {
            const [, contents] = GLib.file_get_contents("/proc/stat");
            const [_, ...cpu] = new TextDecoder()
                .decode(contents)
                .split("\n")[0]
                .trim()
                .split(/\s+/);
            const values = cpu.map(Number);
            const idle = values[3] + values[4];
            const total = values.reduce((sum, value) => sum + value, 0);
            let usage = prev.total
                ? 100 * (1 - (idle - prev.idle) / (total - prev.total))
                : 0;
            prev = {
                idle: idle,
                total: total,
            };
            return usage;
        } catch {
            return 0;
        }
    });

    return (
        <box>
            <label label={data((v) => `CPU: ${v.toFixed(1)}%`)} />
        </box>
    );
};

export default Cpu;
