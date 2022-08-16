<?php
define("ICONS", array(
    "connected" => "󰌘",
    "disconnected" => "󰌙"
));
$status = connection_status();
if ($status == CONNECTION_NORMAL) {
    list("connected" => $icon) = ICONS;
} else {
    list("disconnected" => $icon) = ICONS;
}
echo $icon;

