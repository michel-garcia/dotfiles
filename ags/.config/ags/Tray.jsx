import AstalTray from "gi://AstalTray";
import Gtk from "gi://Gtk";
import { For, createBinding } from "ags";

const tray = AstalTray.get_default();

const TrayItem = ({ item }) => {
    return (
        <menubutton
            $={(self) => {
                self.menuModel = item.menuModel;
                self.insert_action_group("dbusmenu", item.actionGroup);
                item.connect("notify::action-group", () => {
                    self.insert_action_group("dbusmenu", item.actionGroup);
                });
                const popover = self.get_popover();
                if (popover) {
                    popover.add_css_class("tray-menu-popover");
                }
                const gesture = new Gtk.GestureClick({
                    button: 3,
                });
                gesture.connect("pressed", () => {
                    if (popover) {
                        popover.popup();
                    }
                });
                self.add_controller(gesture);
            }}
            tooltipMarkup={item.tooltipMarkup}
        >
            <image gicon={item.gicon} />
        </menubutton>
    );
};

const Tray = () => {
    const items = createBinding(tray, "items");

    return (
        <box class="tray" spacing={10}>
            <For each={items}>{(item) => <TrayItem item={item} />}</For>
        </box>
    );
};

export default Tray;
