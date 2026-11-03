import AstalHyprland from "gi://AstalHyprland";
import { For, createBinding } from "ags";

const hyprland = AstalHyprland.get_default();

const Workspace = ({ workspace }) => {
    const focused = createBinding(hyprland, "focused-workspace");

    return (
        <button
            class={focused.as((f) => {
                let classes = ["workspace"];
                if (f?.id == workspace.id) {
                    classes.push("active");
                } else {
                    let empty = hyprland.clients.every(
                        (c) => c.workspace?.id != workspace.id,
                    );
                    if (empty) {
                        classes.push("empty");
                    }
                }
                return classes.join(" ");
            })}
            onClicked={() =>
                hyprland.dispatch(
                    `hl.dsp.focus({ workspace = ${workspace.id} })`,
                    "",
                )
            }
        >
            <label label={`${workspace.id % 10}`} />
        </button>
    );
};

const Workspaces = ({ gdkmonitor }) => {
    const connector = gdkmonitor.get_connector();

    const workspaces = createBinding(hyprland, "workspaces").as(
        (workspaces) => {
            return workspaces
                .filter((workspace) => {
                    return workspace.monitor?.name === connector;
                })
                .sort((a, b) => a.id - b.id);
        },
    );

    return (
        <box spacing={4}>
            <For each={workspaces}>{(ws) => <Workspace workspace={ws} />}</For>
        </box>
    );
};

export default Workspaces;
