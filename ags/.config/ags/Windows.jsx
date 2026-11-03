import AstalHyprland from "gi://AstalHyprland";
import { For, createBinding, createState } from "ags";

const hyprland = AstalHyprland.get_default();
const addressOf = (address) => `0x${String(address).replace(/^0x/i, "")}`;

const Window = ({ client }) => {
    const focused = createBinding(hyprland, "focused-client");
    const address = addressOf(client.address);

    return (
        <button
            class={focused(
                (f) =>
                    `window ${address === addressOf(f?.address) ? "active" : ""}`,
            )}
            onClicked={() =>
                hyprland.dispatch(
                    `hl.dsp.focus({ window = "address:${address}" })`,
                    "",
                )
            }
        >
            <label
                ellipsize={3}
                label={`[ ${client.class} ]`}
                maxWidthChars={32}
            />
        </button>
    );
};

const Windows = ({ gdkmonitor }) => {
    const [clients, setClients] = createState([]);

    const getClients = () => {
        try {
            const connector = gdkmonitor.get_connector();
            const monitor = hyprland.monitors.find((m) => m.name === connector);
            const workspace = monitor?.activeWorkspace;
            if (!workspace) {
                setClients([]);
                return;
            }
            const current = JSON.parse(hyprland.message("j/clients"));
            return current
                .filter((c) => c.workspace.id === workspace.id)
                .sort((a, b) => a.at[0] - b.at[0]);
        } catch (e) {
            return [];
        }
    };

    return (
        <box
            $={(self) => {
                const update = () => {
                    const current = getClients();
                    setClients((prev) => {
                        if (prev.length !== current.length) {
                            return current;
                        }
                        const changed = prev.every(
                            (c, i) =>
                                c.address !== current[i].address ||
                                c.at[0] !== current[i].at[0],
                        );
                        return changed ? current : prev;
                    });
                };
                update();
                const signals = [
                    hyprland.connect("event", update),
                    hyprland.connect("client-added", update),
                    hyprland.connect("client-removed", update),
                ];
                const poll = setInterval(update, 200);
                self.connect("destroy", () => {
                    clearInterval(poll);
                    signals.forEach((id) => hyprland.disconnect(id));
                });
            }}
            spacing={4}
        >
            <For each={clients}>{(client) => <Window client={client} />}</For>
        </box>
    );
};

export default Windows;
