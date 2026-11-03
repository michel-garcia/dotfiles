import AstalBattery from "gi://AstalBattery";
import { createBinding } from "ags";

const battery = AstalBattery.get_default();

const Battery = () => {
    if (!battery) {
        return null;
    }

    const percentage = createBinding(battery, "percentage");

    return (
        <box>
            <label
                label={percentage.as((p) => `BAT: ${Math.round(p * 100)}%`)}
            />
        </box>
    );
};

export default Battery;
