import { createBinding, For, This } from "ags";
import app from "ags/gtk4/app";

import BottomBar from "./BottomBar";
import TopBar from "./TopBar";
import style from "./style.scss";

app.start({
    css: style,
    main() {
        const monitors = createBinding(app, "monitors");

        return (
            <For each={monitors}>
                {(monitor) => (
                    <This this={app}>
                        <TopBar gdkmonitor={monitor} />
                        <BottomBar gdkmonitor={monitor} />
                    </This>
                )}
            </For>
        );
    },
});
