import GLib from "gi://GLib";
import { createPoll } from "ags/time";

const Volume = ({ interval = 500 }) => {
    const volume = createPoll(0, interval, () => {
        try {
            let [success, stdout] = GLib.spawn_command_line_sync(
                "wpctl get-volume @DEFAULT_AUDIO_SINK@",
            );
            if (!success) return { vol: 0, mute: false };

            let output = new TextDecoder().decode(stdout).trim();
            let match = output.match(/([\d.]+)/);
            return match ? parseFloat(match[1]) : 0;
        } catch (e) {
            return 0;
        }
    });

    return (
        <box>
            <label label={volume((v) => `VOL: ${Math.round(v * 100)}%`)} />
        </box>
    );
};

export default Volume;
